package webProject2017;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class nearestMountain {

	private int code;
	private String name;
	private double my_lat, my_lon,dist;
	int count = 0;


	public double getDist() {
		return dist;
	}


	public void setDist(double dist) {
		this.dist = dist;
	}
	public int getCode() {
		return code;
	}


	public void setCode(int code) {
		this.code = code;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public double getMy_lat() {
		return my_lat;
	}


	public void setMy_lat(double my_lat) {
		this.my_lat = my_lat;
	}


	public double getMy_lon() {
		return my_lon;
	}


	public void setMy_lon(double my_lon) {
		this.my_lon = my_lon;
	}






	public double calDistance(double lat, double lon){   // 거리 계산식
	    double theta , dist;  
	    theta = my_lon - lon;  
	    dist = Math.sin(deg2rad(my_lat)) * Math.sin(deg2rad(lat)) + Math.cos(deg2rad(my_lat))* Math.cos(deg2rad(lat)) * Math.cos(deg2rad(theta)); 
	    dist = Math.acos(dist);  
	    dist = rad2deg(dist);  
	    dist = dist * 60 * 1.1515;   
	    dist = dist * 1.609344;    //mile 에서 km
	    // dist = dist * 1000.0;     // km에서 m로 

	    return dist; // 내 위치부 등산코스와의 거리 
	}  
	  
	    // 계산식
	private double deg2rad(double deg){  
	    return (double)(deg * Math.PI / (double)180d);  
	}  
	  
	    // 계산식
	private double rad2deg(double rad){  
	    return (double)(rad * (double)180d / Math.PI);  
	} 
	
}
