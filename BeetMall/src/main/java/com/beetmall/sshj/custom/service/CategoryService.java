package com.beetmall.sshj.custom.service;

import java.util.List;

import com.beetmall.sshj.custom.vo.CategoryFarmVO;
import com.beetmall.sshj.custom.vo.CategoryVO;

public interface CategoryService {

	public List<CategoryFarmVO> mapAllRecord();

	public List<CategoryVO> categorylist();

}