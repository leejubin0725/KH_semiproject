package com.kh.semi.common.scheduling;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kh.semi.Inquiry.model.service.InquiryService;
import com.kh.semi.order.model.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class FileDeleteScheduler {

	private final ServletContext application;
	private final OrderService oService;
	private final InquiryService iService;
	
	@Scheduled(cron = "1 * * * * *")
	public void deleteOrderFile() {
		log.debug("주문 파일 삭제 스케쥴러 시작");
		List<String> list = oService.selectOrdersImgList();
		log.debug("DB TABLE LIST :  {}" , list);
		
		File path = new File(application.getRealPath("/resources/images/Orders/"));
		File[] files = path.listFiles();
		
		if(files == null) {
			log.debug("디렉토리가 없습니다. 삭제 스케줄러 끝.");
			return;
		}
		
		List<File> filesList = Arrays.asList(files);
		log.debug("SERVER FILE LIST :  {}" , filesList);
		
		if(list != null) {
			for(File serverFile : filesList) {
				String fileName = serverFile.getName();
				fileName = "/resources/images/Orders/" + fileName;
				
				if(list.indexOf(fileName) == -1) {
					log.debug(fileName+"을 삭제합니다.");
					serverFile.delete();
				}
			}
		}
		
		log.debug("주문 파일 삭제 스케쥴러 끝");
	}
	
	@Scheduled(cron = "31 * * * * *")
	public void deleteInquiryFile() {
		log.debug("문의 파일 삭제 스케쥴러 시작");
		List<String> list = iService.selectInquiryImgList();
		log.debug("DB TABLE LIST :  {}" , list);
		
		File path = new File(application.getRealPath("/resources/images/Inquiry/"));
		File[] files = path.listFiles();
		
		if(files == null) {
			log.debug("디렉토리가 없습니다. 삭제 스케줄러 끝.");
			return;
		}
		
		List<File> filesList = Arrays.asList(files);
		log.debug("SERVER FILE LIST :  {}" , filesList);
		
		if(list != null) {
			for(File serverFile : filesList) {
				String fileName = serverFile.getName();
				fileName = "/resources/images/Inquiry/" + fileName;
				
				if(list.indexOf(fileName) == -1) {
					log.debug(fileName+"을 삭제합니다.");
					serverFile.delete();
				}
			}
		}
		
		log.debug("문의 파일 삭제 스케쥴러 끝");
	}
}
