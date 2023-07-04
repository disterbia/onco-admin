package net.huray.onco.service;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.CompleteMultipartUploadRequest;
import com.amazonaws.services.s3.model.GroupGrantee;
import com.amazonaws.services.s3.model.InitiateMultipartUploadRequest;
import com.amazonaws.services.s3.model.InitiateMultipartUploadResult;
import com.amazonaws.services.s3.model.PartETag;
import com.amazonaws.services.s3.model.Permission;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.services.s3.model.UploadPartRequest;
import com.amazonaws.services.s3.model.UploadPartResult;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.File;
import net.huray.onco.repository.FileRepository;

@Slf4j
@Service
public class FileService {
	
	@Value("${ncp.storage.end-point}")
	private String endPoint;
	
	@Value("${ncp.storage.region-name}")
	private String regionName;
	
	@Value("${ncp.key.access}")
	private String accessKey;
	
	@Value("${ncp.key.secret}")
	private String secretKey;
	
	@Value("${ncp.storage.bucket-name}")
	private String bucketName;
	
	private static final String imageExts[] = {
		"jpg", "jpeg", "png", "gif", "bmp"
	};
	
	private final FileRepository fileRepository;
	
	public FileService(FileRepository fileRepository) {
		this.fileRepository = fileRepository;
	}
	
	//저장
	public void save(String refCode, int refIdx, ArrayList<MultipartFile> files) {
		try {
			for (MultipartFile multipartFile : files) {
				
				String fileName = uuid();
				
				File file = File
						.builder()
						.ftRefCode(refCode)
						.ftRefIdx(refIdx)
						.ftLevel(1)
						.ftName(multipartFile.getOriginalFilename())
						.ftUuid(fileName)
						.ftSize(multipartFile.getSize())
						.ftExt(fileExt(multipartFile.getOriginalFilename()))
						.ftWdate(new Date())
						.build();
				fileRepository.save(file);
				
				s3Upload(multipartFile, fileName);
			}
		} catch (Exception e) {
			log.error("save error: " + e);
		}
	}
	
	//에디터 이미지 저장
	public String saveOne(String refCode, int refIdx, MultipartFile multipartFile) {
		
		String returnInfo = "&bNewLine=true"+"&sFileName="+multipartFile.getOriginalFilename();
		
		String fileName = uuid();
		
		try {
			File file = File
						.builder()
						.ftRefCode(refCode)
						.ftRefIdx(refIdx)
						.ftLevel(1)
						.ftName(multipartFile.getOriginalFilename())
						.ftUuid(fileName)
						.ftSize(multipartFile.getSize())
						.ftExt(fileExt(multipartFile.getOriginalFilename()))
						.ftWdate(new Date())
						.build();
				fileRepository.save(file);
				
				s3Upload(multipartFile, fileName);
			
		} catch (Exception e) {
			log.error("save error: " + e);
		}
		
		return returnInfo + "&sFileURL=/mng/download/"+fileName;
	}
	
	//파일리스트
	public List<File> findAll(String refCode, long refIdx){
		return fileRepository.findAllByFtRefCodeAndFtRefIdxAndFtLevel(refCode, refIdx, 1);
	}
	
	//파일명
	private String uuid() {
		return UUID.randomUUID().toString();
	}
	
	//확장자
	private String fileExt(String fileName) {
		try {
			return fileName.substring(fileName.lastIndexOf(".") + 1);
		} catch (Exception e) {
			log.error("fileExt Error: " + e);
			return "";
		}
	}
	
	private AmazonS3 s3Client() {
		return AmazonS3ClientBuilder.standard()
	    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
	    .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
	    .build();
	}
	
	
	private String s3Upload(MultipartFile multipartFile, String objectName) throws IOException {
        AmazonS3 s3 = s3Client();

        InitiateMultipartUploadResult initiateMultipartUploadResult = s3.initiateMultipartUpload(new InitiateMultipartUploadRequest(bucketName, objectName));
        String uploadId = initiateMultipartUploadResult.getUploadId();

        List<PartETag> partETagList = new ArrayList<>();

        long partSize = 10 * 1024 * 1024;
        long fileOffset = 0;
        long contentLength = multipartFile.getSize();

        for (int i = 1; fileOffset < contentLength; i++) {
            partSize = Math.min(partSize, (contentLength - fileOffset));

            UploadPartRequest uploadPartRequest = new UploadPartRequest()
                    .withBucketName(bucketName)
                    .withKey(objectName)
                    .withUploadId(uploadId)
                    .withPartNumber(i)
                    .withInputStream(multipartFile.getInputStream())
                    .withFileOffset(fileOffset)
                    .withPartSize(partSize);

            UploadPartResult uploadPartResult = s3.uploadPart(uploadPartRequest);
            partETagList.add(uploadPartResult.getPartETag());

            fileOffset += partSize;
        }

        s3.completeMultipartUpload(new CompleteMultipartUploadRequest(bucketName, objectName, uploadId, partETagList));
        s3Acl(s3, objectName);

        return objectName;
    }
	
	//다운로드
	public void s3Downlaod(HttpServletResponse response, String objectName) throws IOException {
		
		File file = fileRepository.findByFtUuidAndFtLevelNot(objectName, 10);

        AmazonS3 s3 = s3Client();
        // download object
        S3ObjectInputStream s3ObjectInputStream = null;
        ServletOutputStream outputStream = null;
        try {
            S3Object s3Object = s3.getObject(bucketName, objectName);
            s3ObjectInputStream = s3Object.getObjectContent();
            	
            if(isImage(file.getFtExt())) {
            	response.setContentType("image/"+file.getFtExt());	
            } else {
                response.setContentType("application/octet-stream");	// 다운로드 파일
                response.setHeader("Content-Disposition", "attachment;filename="+new String(file.getFtName().getBytes("KSC5601"), "8859_1"));
            }

            outputStream = response.getOutputStream();

            byte[] bytesArray = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = s3ObjectInputStream.read(bytesArray)) != -1) {
                outputStream.write(bytesArray, 0, bytesRead);
            }
        } catch (Exception e) {
            response.setHeader("Set-Cookie", "fileDownload=false; path=/");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Content-Type","text/html; charset=utf-8");
            OutputStream out = null;
            try {
                out = response.getOutputStream();
                byte[] data = new String("download fail..").getBytes();
                out.write(data, 0, data.length);
            } catch (Exception ignore) {
                log.error("StorageUtil ignore >> {}", ignore.getMessage());
            } finally {
                if (out != null) {
                    out.close();
                }
            }
            log.error("getStorage >> {}", e.getMessage());
        } finally {
            if (s3ObjectInputStream != null) {
                s3ObjectInputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
	
	//파일 논리 삭제
	public void delete(String refCode, int refIdx) {
		List<File> files = findAll(refCode, refIdx);
		for (File file : files) {
			file.setFtLevel(10);
			fileRepository.save(file);
		}
	}
	
	//파일 물리 경로 삭제 ft_level = 10 인것만 추려내서 물리 삭제 진행
	public void s3Delete() {
		AmazonS3 s3 = s3Client();
		List<File> files = fileRepository.findAllByFtLevel(10);
		for (File file : files) {
			s3.deleteObject(bucketName, file.getFtUuid());
			fileRepository.delete(file);
		}
	}

	//acl
	private void s3Acl(AmazonS3 s3, String objectName) {
        AccessControlList accessControlList = s3.getBucketAcl(bucketName);
        accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.Read);
        s3.setObjectAcl(bucketName, objectName,  accessControlList);
    }

	//mime
	private boolean isImage(String extension) {
		if(Arrays.asList(imageExts).contains(extension)) {
			return true;
		}
		return false;
	}
	

}
