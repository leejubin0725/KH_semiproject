package com.kh.semi.common;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Utils {
	
public static String saveFile(MultipartFile upfile , String path) {
		
		// 랜덤파일명 생성하기
		String originName = upfile.getOriginalFilename();
		String currentTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random = (int)(Math.random() * 90000 + 10000); // 10000 - 99999 (5자리 랜덤값)
		String ext = originName.substring(originName.indexOf("."));
		
		String changeName = currentTime + random + ext;
		
		try {
			upfile.transferTo(new File(path+changeName)); // 파일 객체를 path 경로 상으로 이동 시킴
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}

}
