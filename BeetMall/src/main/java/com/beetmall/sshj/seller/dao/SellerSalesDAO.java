package com.beetmall.sshj.seller.dao;

import java.util.List;

import com.beetmall.sshj.seller.vo.SellerSalesVO;

public interface SellerSalesDAO {
	// 카테고리 리스트 불러오기
	public List<SellerSalesVO> allCategoryList();
	// 매출분석 데이터 리스트
	public List<SellerSalesVO> salesDataList(SellerSalesVO vo);
}
