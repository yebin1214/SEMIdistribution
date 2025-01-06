package com.kh.product.model.dao;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.product.model.vo.Product;
import com.kh.user.model.dao.ReviewDao;
import com.kh.user.model.vo.Review;

import static com.kh.common.template.JDBCTemplate.close;

public class productDao {
	private Properties prop = new Properties();

	public productDao() {
		try {
			// XML 파일 경로 설정
			String fileName = ReviewDao.class.getResource("/sql/product/product.xml").getPath();
			prop.loadFromXML(new FileInputStream(fileName)); // XML 파일 로드
		} catch (Exception e) {
			System.err.println("XML 파일 로드 실패: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public Product productReview(Connection conn, int productNo) {
		Product product = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		try {
			// 상품 정보 조회
			String productSql = prop.getProperty("selectProductDetail");
			pstmt = conn.prepareStatement(productSql);
			pstmt.setInt(1, productNo);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				product = new Product();
				product.setProductNo(rset.getInt("PRODUCT_NO"));
				product.setStoreNo(rset.getInt("STORE_NO")); // 수정된 setStoreName
				product.setProductName(rset.getString("PRODUCT_NAME"));
				product.setProductPrice(rset.getInt("PRODUCT_PRICE"));
				product.setImageUrl(rset.getString("IMAGE_URL"));
				product.setLinked(rset.getString("LINKED"));
			}

			close(rset);
			close(pstmt);

			// 리뷰 정보 조회
			String reviewSql = prop.getProperty("selectReviewsByProductNo");
			pstmt = conn.prepareStatement(reviewSql);
			pstmt.setInt(1, productNo);

			rset = pstmt.executeQuery();

			List<Review> reviews = new ArrayList<>();
			while (rset.next()) {
				Review review = Review.builder().reviewNo(rset.getInt("REVIEW_NO"))
						.reviewWriter(rset.getInt("REVIEW_WRITER")).productNo(rset.getInt("PRODUCT_NO"))
						.reviewContent(rset.getString("REVIEW_CONTENT")).reviewDate(rset.getTimestamp("REVIEW_DATE"))
						.reviewScore(rset.getInt("REVIEW_SCORE")).build();
				reviews.add(review);
			}

			if (product != null) {
				product.setReviews(reviews);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return product;
	}
}
