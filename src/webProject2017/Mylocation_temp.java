package webProject2017;

import java.util.ArrayList;

public class Mylocation_temp {
	double lat;
	double lon;
	
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	
	public ArrayList<Mylocation_temp> getMyLocation(){
		ArrayList<Mylocation_temp> mylocation = new ArrayList<Mylocation_temp>();
		Mylocation_temp loc = new Mylocation_temp();
		
		loc.setLat(getLat());
		loc.setLon(getLon());
		mylocation.add(loc);
		
		return mylocation;
	}
	
	
}
