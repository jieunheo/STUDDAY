<%@ page language="java" pageEncoding="UTF-8" contentType="image/jpeg"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="nl.captcha.Captcha" %>
<%@page import="nl.captcha.Captcha.Builder" %>
<%@page import="nl.captcha.backgrounds.FlatColorBackgroundProducer" %>
<%@page import="java.awt.Color" %>
<%
	//자동등록방지 코드를 이미지로 출력한다.
	Captcha mCaptcha;
	Builder mBuilder;
	String  mAnswer;

	mBuilder= new Captcha.Builder(150, 50); //이미지 크기
	mBuilder.addText();
	mBuilder.addBackground(new FlatColorBackgroundProducer(Color.WHITE)); //배경색
	mBuilder.addBorder();
	mBuilder.addNoise();
	mCaptcha = mBuilder.build();
	mAnswer = mCaptcha.getAnswer(); //이미지 안의 문자를 받는다

	OutputStream mOut = response.getOutputStream();
	ImageIO.write(mCaptcha.getImage(),"jpg", mOut);
	mOut.close();

	request.getSession().setAttribute("sign",mAnswer); //해당 값을 세션으로 저장한다
%>