package dev.mvc.notice;

import java.util.List;

public interface NoticeProcInter {
    /**
     * 등록 insert id="create" parameterType="dev.mvc.notice.NoticeVO"
     * 
     * @param noticeVO
     * @return 등록된 레코드 갯수
     */
    public int create(NoticeVO noticeVO);

    /**
     * 등록 순서별 목록 select id="list" resultType="dev.mvc.notice.NoticeVO"
     * 
     * @return
     */
    public List<NoticeVO> list();

    /**
     * 조회 select id="read" resultType="dev.mvc.notice.NoticeVO" parameterType="int"
     * 
     * @param noticeno 카테고리 그룹 번호, PK
     * @return NoticeVO
     */
    public NoticeVO read(int noticeno);

    /**
     * 수정 처리 update id="update" parameterType="dev.mvc.notice.NoticeVO"
     * 
     * @param NoticeVO
     * @return 수정된 레코드 갯수
     */
    public int update(NoticeVO noticeVO);

    /**
     * 삭제 처리 delete id="delete" parameterType="int"
     * 
     * @param noticeno
     * @return 처리된 레코드 갯수
     */
    public int delete(int noticeno);
}
