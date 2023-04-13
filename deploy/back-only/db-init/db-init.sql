-- Teachers
CREATE TABLE Teachers
(
    t_teacher_id    serial      NOT NULL,
    c_teacher_name  varchar(50) NOT NULL,
    c_teacher_email varchar(70),

    PRIMARY KEY (t_teacher_id)
);


-- Users(students)
CREATE TABLE Users
(
    u_user_id            serial       NOT NULL,
    u_user_email         varchar(70)  NOT NULL,
    u_user_hashed_passwd varchar(256) NOT NULL,
    u_user_nickname      varchar(20)  NOT NULL,
    u_user_start_year    varchar(10)  NOT NULL,
    u_user_group         varchar(20)  NOT NULL, -- "default", "maintainer", "admin"

    PRIMARY KEY (u_user_id),
    UNIQUE (u_user_email)
);


-- Courses
CREATE TABLE Courses
(
    c_course_id       serial        NOT NULL,
    -- 课程编号示例: 线性代数I-A(03)/ B01GB001Y-A03
    c_course_code     char(9)       NOT NULL, -- B01GB001Y
    c_course_code_seq varchar(5),             -- A
    c_course_name     varchar(30)   NOT NULL,
    c_teacher_id      int           NOT NULL,
    c_semester        varchar(10)   NOT NULL, -- "spring", "fall", "summer", "both"
    c_credit          decimal(4, 2) NOT NULL,
    c_degree          int           NOT NULL, -- 0,
    c_category        varchar(15)   NOT NULL, -- "public", "specialized"
    c_status          int           NOT NULL, -- 0 = "unverified", 1 = "verified"
    c_submit_user_id  int           NOT NULL,

    PRIMARY KEY (c_course_id),
    FOREIGN KEY (c_teacher_id) REFERENCES Teachers (t_teacher_id),
    FOREIGN KEY (c_submit_user_id) REFERENCES Users (u_user_id),
    UNIQUE (c_course_code, c_course_code_seq, c_teacher_id)
);

-- Reviews
CREATE TABLE Reviews
(
    -- info, id check
    r_review_id        serial    NOT NULL,
    r_course_id        int       NOT NULL,
    r_user_id          int       NOT NULL,
    -- rating issue
    r_create_time      timestamp NOT NULL,
    r_last_update_time timestamp NOT NULL,
    r_overall_rec      int       NOT NULL, -- 0,1,2
    r_rate_quality     int       NOT NULL, -- 0-5
    r_rate_difficulty  int       NOT NULL, -- 0-5
    r_rate_workload    int       NOT NULL, -- 0-5
    r_comment_text     text      NOT NULL,
    r_my_grade         varchar(10),
    r_my_major         int,

    PRIMARY KEY (r_review_id),
    FOREIGN KEY (r_course_id) REFERENCES Courses (c_course_id),
    FOREIGN KEY (r_user_id) REFERENCES Users (u_user_id)
);

-- Add some fake data
INSERT INTO users (u_user_email, u_user_hashed_passwd, u_user_nickname, u_user_start_year, u_user_group)
VALUES ('test_1@mails.ucas.ac.cn', '48690', 'TEST_USER_1', '2020', 'default');
INSERT INTO users (u_user_email, u_user_hashed_passwd, u_user_nickname, u_user_start_year, u_user_group)
VALUES ('test_2@mails.ucas.ac.cn', '48690', 'TEST_USER_2', '2020', 'default');
INSERT INTO users (u_user_email, u_user_hashed_passwd, u_user_nickname, u_user_start_year, u_user_group)
VALUES ('test_3@mails.ucas.ac.cn', '48690', '一个有中文名的用户', '2020', 'default');
INSERT INTO users (u_user_email, u_user_hashed_passwd, u_user_nickname, u_user_start_year, u_user_group)
VALUES ('test_4@mails.ucas.ac.cn', '48690', '另一个有中文名的用户', '2020', 'default');

INSERT INTO teachers (c_teacher_name, c_teacher_email)
VALUES ('Tony', 'teacher_1@mails.ucas.ac.cn');
INSERT INTO teachers (c_teacher_name, c_teacher_email)
VALUES ('从某种意义上讲', 'teacher_2@mails.ucas.ac.cn');
INSERT INTO teachers (c_teacher_name, c_teacher_email)
VALUES ('莱布尼茨第 128 代传人', 'teacher_3@mails.ucas.ac.cn');
INSERT INTO teachers (c_teacher_name, c_teacher_email)
VALUES ('等于是', 'teacher_4@mails.ucas.ac.cn');
INSERT INTO teachers (c_teacher_name, c_teacher_email)
VALUES ('包包', 'teacher_5@mails.ucas.ac.cn');

INSERT INTO courses (c_course_code, c_course_code_seq, c_course_name, c_teacher_id, c_semester, c_credit, c_degree, c_category,
                     c_status, c_submit_user_id)
VALUES ('B0911011Y', '02', '操作系统研讨课', 4, 'autumn', 2.0, 0, 'specialized', 1, 1);
INSERT INTO courses (c_course_code, c_course_code_seq, c_course_name, c_teacher_id, c_semester, c_credit, c_degree, c_category,
                     c_status, c_submit_user_id)
VALUES ('B0912024Y', null, '计算机网络', 1, 'autumn', 3.0, 0, 'specialized', 1, 1);
INSERT INTO courses (c_course_code, c_course_code_seq, c_course_name, c_teacher_id, c_semester, c_credit, c_degree, c_category,
                     c_status, c_submit_user_id)
VALUES ('B0911002Y', '01', '数据结构', 2, 'spring', 3.0, 0, 'specialized', 1, 1);
INSERT INTO courses (c_course_code, c_course_code_seq, c_course_name, c_teacher_id, c_semester, c_credit, c_degree, c_category,
                     c_status, c_submit_user_id)
VALUES ('B????????', null, '一个未审核通过的课程', 1, 'spring', 3.0, 0, 'specialized', 0, 1);
INSERT INTO courses (c_course_code, c_course_code_seq, c_course_name, c_teacher_id, c_semester, c_credit, c_degree, c_category,
                     c_status, c_submit_user_id)
VALUES ('B0911011Y', '01', '操作系统研讨课', 5, 'autumn', 2.0, 0, 'specialized', 1, 1);


INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (5, 1, current_timestamp, current_timestamp, 1, 1, 2, 5, '给包包打 call', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 1, current_timestamp, current_timestamp, 1, 1, 2, 5, '呜呜呜呜👴最喜欢这个课了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 2, current_timestamp, current_timestamp, 2, 5, 1, 4, '等于是典型的等于是了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 3, current_timestamp, current_timestamp, 5, 5, 3, 2, '我哭死', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 4, current_timestamp, current_timestamp, 2, 3, 1, 4, '从某种意义上讲这可真的是太有意义了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 1, current_timestamp, current_timestamp, 4, 3, 4, 2, '😘🤦‍♂️💕🤷‍♂️🤷‍♀️😁🤷‍♂️🤣🤣😉😂😘😉🙂😗😗', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 2, current_timestamp, current_timestamp, 3, 3, 4, 2,
        '(┬┬﹏┬┬)☆*: .｡. o(≧▽≦)o .｡.:*☆(┬┬﹏┬┬)ψ(｀∇´)ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 3, current_timestamp, current_timestamp, 4, 2, 2, 2,
        '(┬┬﹏┬┬)ψ(｀∇´)（づ￣3￣）づ╭❤️～(￣o￣) . z Z(o-ωｑ)).oO 困ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (1, 4, current_timestamp, current_timestamp, 4, 2, 2, 2, '1111111', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 1, current_timestamp, current_timestamp, 1, 1, 2, 5, '呜呜呜呜👴最喜欢这个课了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 2, current_timestamp, current_timestamp, 2, 5, 1, 4, '等于是典型的等于是了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 3, current_timestamp, current_timestamp, 5, 5, 3, 2, '我哭死', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 4, current_timestamp, current_timestamp, 2, 3, 1, 4, '从某种意义上讲这可真的是太有意义了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 1, current_timestamp, current_timestamp, 4, 3, 4, 2, '😘🤦‍♂️💕🤷‍♂️🤷‍♀️😁🤷‍♂️🤣🤣😉😂😘😉🙂😗😗', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 2, current_timestamp, current_timestamp, 3, 3, 4, 2,
        '(┬┬﹏┬┬)☆*: .｡. o(≧▽≦)o .｡.:*☆(┬┬﹏┬┬)ψ(｀∇´)ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 3, current_timestamp, current_timestamp, 4, 2, 2, 2,
        '(┬┬﹏┬┬)ψ(｀∇´)（づ￣3￣）づ╭❤️～(￣o￣) . z Z(o-ωｑ)).oO 困ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (2, 4, current_timestamp, current_timestamp, 4, 2, 2, 2, '1111111', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 1, current_timestamp, current_timestamp, 1, 1, 2, 5, '呜呜呜呜👴最喜欢这个课了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 2, current_timestamp, current_timestamp, 2, 5, 1, 4, '等于是典型的等于是了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 3, current_timestamp, current_timestamp, 5, 5, 3, 2, '我哭死', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 4, current_timestamp, current_timestamp, 2, 3, 1, 4, '从某种意义上讲这可真的是太有意义了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 1, current_timestamp, current_timestamp, 4, 3, 4, 2, '😘🤦‍♂️💕🤷‍♂️🤷‍♀️😁🤷‍♂️🤣🤣😉😂😘😉🙂😗😗', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 2, current_timestamp, current_timestamp, 3, 3, 4, 2,
        '(┬┬﹏┬┬)☆*: .｡. o(≧▽≦)o .｡.:*☆(┬┬﹏┬┬)ψ(｀∇´)ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 3, current_timestamp, current_timestamp, 4, 2, 2, 2,
        '(┬┬﹏┬┬)ψ(｀∇´)（づ￣3￣）づ╭❤️～(￣o￣) . z Z(o-ωｑ)).oO 困ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (3, 4, current_timestamp, current_timestamp, 4, 2, 2, 2, '1111111', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 1, current_timestamp, current_timestamp, 1, 1, 2, 5, '呜呜呜呜👴最喜欢这个课了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 2, current_timestamp, current_timestamp, 2, 5, 1, 4, '等于是典型的等于是了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 3, current_timestamp, current_timestamp, 5, 5, 3, 2, '我哭死', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 4, current_timestamp, current_timestamp, 2, 3, 1, 4, '从某种意义上讲这可真的是太有意义了', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 1, current_timestamp, current_timestamp, 4, 3, 4, 2, '😘🤦‍♂️💕🤷‍♂️🤷‍♀️😁🤷‍♂️🤣🤣😉😂😘😉🙂😗😗', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 2, current_timestamp, current_timestamp, 3, 3, 4, 2,
        '(┬┬﹏┬┬)☆*: .｡. o(≧▽≦)o .｡.:*☆(┬┬﹏┬┬)ψ(｀∇´)ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 3, current_timestamp, current_timestamp, 4, 2, 2, 2,
        '(┬┬﹏┬┬)ψ(｀∇´)（づ￣3￣）づ╭❤️～(￣o￣) . z Z(o-ωｑ)).oO 困ψ（￣︶￣）↗　<(￣︶￣)↗[GO!]', null, 0);
INSERT INTO reviews (r_course_id, r_user_id, r_create_time, r_last_update_time, r_overall_rec, r_rate_quality,
                     r_rate_difficulty, r_rate_workload, r_comment_text, r_my_grade, r_my_major)
VALUES (4, 4, current_timestamp, current_timestamp, 4, 2, 2, 2, '1111111', null, 0);

CREATE MATERIALIZED VIEW AvgRating AS
(
    SELECT r_course_id, AVG(r_overall_rec) AS r_avg_overall_rec, AVG(r_rate_quality) AS r_avg_rate_quality,
           AVG(r_rate_difficulty) AS r_avg_rate_difficulty, AVG(r_rate_workload) AS r_avg_rate_workload
    FROM reviews
    GROUP BY r_course_id
);
