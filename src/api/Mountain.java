package api;

import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
/**
 * 
 * @author JunHyeong
 *
 */
public class Mountain {

	private String sreach_info;
	private String sreachNo_img;
	private String address;
	private String height;
	private String details;
	private String summary;
	private String image1;
	private String image2;
	private String image3;
	
	public String getSreach_info() {
		return sreach_info;
	}

	public void setSreach_info(String sreach_info) {
		this.sreach_info = sreach_info;
	}

	public String getSreachNo_img() {
		return sreachNo_img;
	}

	public void setSreachNo_img(String sreachNo_img) {
		this.sreachNo_img = sreachNo_img;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}
	
	
	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
	
	public void infoMountainAPI() {
		String addr_info = "http://apis.data.go.kr/1400000/service/cultureInfoService/mntInfoOpenAPI";
		String type_info = "&searchWrd=";	
		sreach_info =  getSreach_info();
//		sreach_info =  "북한산";
//		System.out.println("sreach_herb : " + sreach_info);
		String serviceKey = "?serviceKey=vj4dxuSsj2rbjVI5s7bf1E0El21porvaChQRh5ggyetZiMvDs6UABEYKDA9pi7gpvI5tKW8WSysUOtBmux2M2w%3D%3D";

		try { 
			 sreach_info = URLEncoder.encode(sreach_info, "UTF-8");
	     	
			 addr_info = addr_info + serviceKey + type_info + sreach_info;
		//	 addr_img = addr_img + serviceKey + type_img + sreachNo_img;
			
//	     		addr = addr + sreach_type + serviceKey + + "&numOfRows=1" + "&pageNo=" + page; //1개씩 출력
//	     		addr = addr + serviceKey +"&numOfRows=534"; //전제 출력
	     		
	     		// parse the document
	     		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
	     		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
	     		Document doc = dBuilder.parse(addr_info);
	     		// root tag 
	     		doc.getDocumentElement().normalize();
	     		//System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result

	     		NodeList nList = doc.getElementsByTagName("item");
	     		
	     		for(int temp = 0; temp < nList.getLength(); temp++){		
	     			Node nNode = nList.item(temp);
	     			if(nNode.getNodeType() == Node.ELEMENT_NODE){
	     								
	     				Element eElement = (Element) nNode;
	     				
//   				System.out.println("주소 : " + getTagValue("mntiadd", eElement));
//   				System.out.println("높이  : " + getTagValue("mntihigh", eElement));
//   				System.out.println("이미지번호 : " + getTagValue("mntilistno", eElement));
//   				System.out.println("설명 1 : " + getTagValue("mntidetails", eElement));
//   				System.out.println("설명 2 : " + getTagValue("mntisummary", eElement));
	     		
	     				setAddress(getTagValue("mntiadd", eElement)) ;
	     				setHeight(getTagValue("mntihigh", eElement));
	     				setDetails(getTagValue("mntidetails", eElement));
	     				setSummary(getTagValue("mntisummary", eElement)) ;
	     				setSreachNo_img(getTagValue("mntilistno", eElement));
	     				
//	    				ih.setPlantClsscNm(getTagValue("plantClsscNm", eElement)); 
//	    				ih.setMclltSfrmdNm( getTagValue("mclltSfrmdNm", eElement));
//	    				ih.setPlantFamlNm (getTagValue("plantFamlNm", eElement));
//	    				ih.setPlantEclgDscrt (getTagValue("plantEclgDscrt", eElement));
//	    				ih.setMclltDistrDscrt (getTagValue("mclltDistrDscrt", eElement));
//	    				ih.setUseway (getTagValue("usMthodDscrt", eElement));
//	    				ih.setEatway (getTagValue("mclltDoseMthodDscrt", eElement));
//	    				ih.setImage1 (getTagValue("mclltPnrmImageFileNm", eElement));
//	    				ih.setImage2 (getTagValue("mclltUsRgnImageFileNm", eElement));
//	    				ih.setImage3 (getTagValue("mdciUsImageFileNm", eElement));

	       				}	// if end
	     		}	// for end
	     		
	     		
	     	}
	     catch (Exception e) 
	     {
	         e.printStackTrace();
	     } //try
	}
	
	public void imgMountainAPI(){
		String addr_img = "http://apis.data.go.kr/1400000/service/cultureInfoService/mntInfoImgOpenAPI";
		String type_img = "&mntiListNo=";	
	//	int sreachNo_img =  request.getParameter("name");
		String sreachNo_img =  getSreachNo_img();
		String serviceKey = "?serviceKey=vj4dxuSsj2rbjVI5s7bf1E0El21porvaChQRh5ggyetZiMvDs6UABEYKDA9pi7gpvI5tKW8WSysUOtBmux2M2w%3D%3D";
				
		 try { 
			 addr_img = addr_img + serviceKey + type_img + sreachNo_img;	
				//	String sreachNo + sreachNo_img;
		//	 addr_img = addr_img + serviceKey + type_img + sreachNo_img;
			
//	     		addr = addr + sreach_type + serviceKey + + "&numOfRows=1" + "&pageNo=" + page; //1개씩 출력
//	     		addr = addr + serviceKey +"&numOfRows=534"; //전제 출력

	     		// parse the document
	     		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
	     		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
	     		Document doc = dBuilder.parse(addr_img);
	     		// root tag 
	     		doc.getDocumentElement().normalize();
	     		//System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result

	     		NodeList nList = doc.getElementsByTagName("item");
	     		
	     		for(int temp = 0; temp < nList.getLength(); temp++){		
	     			Node nNode = nList.item(temp);
	     			if(nNode.getNodeType() == Node.ELEMENT_NODE){
	     								
	     				Element eElement = (Element) nNode;
	     				//System.out.println("사진 : " + getTagValue("imgfilename", eElement));
	     				
	     				if(temp == 0)
	     					setImage1(getTagValue("imgfilename", eElement));
	     				else if(temp == 1)
	     					setImage2(getTagValue("imgfilename", eElement));
	     				else if(temp == 2)
	     					setImage3(getTagValue("imgfilename", eElement));

//	    				ih.setPlantClsscNm(getTagValue("plantClsscNm", eElement)); 
//	    				ih.setMclltSfrmdNm( getTagValue("mclltSfrmdNm", eElement));
//	    				ih.setPlantFamlNm (getTagValue("plantFamlNm", eElement));
//	    				ih.setPlantEclgDscrt (getTagValue("plantEclgDscrt", eElement));
//	    				ih.setMclltDistrDscrt (getTagValue("mclltDistrDscrt", eElement));
//	    				ih.setUseway (getTagValue("usMthodDscrt", eElement));
//	    				ih.setEatway (getTagValue("mclltDoseMthodDscrt", eElement));
//	    				ih.setImage1 (getTagValue("mclltPnrmImageFileNm", eElement));
//	    				ih.setImage2 (getTagValue("mclltUsRgnImageFileNm", eElement));
//	    				ih.setImage3 (getTagValue("mdciUsImageFileNm", eElement));

	       				}	// if end
	     		}	// for end
	     		
	     		
	     	}
	     catch (Exception e) 
	     {
	         e.printStackTrace();
	     } //try
	}
	
	
//	public static void main(String args[])	{
//		Mountain m = new Mountain();
//		String sreach_info = "북한산";
//		m.setSreach_info(sreach_info);
//		
//		m.infoMountainAPI();
//		m.imgMountainAPI();
//
//		int sreachNo_img = m.getSreachNo_img();
//		String address = m.getAddress();
//		String height = m.getHeight();
//		String details = m.getDetails();
//		String summary = m.getSummary();
//		String image1 = m.getImage1();
//		String image2 = m.getImage2();
//		String image3 = m.getImage3();
//		
//		System.out.println("주소 : " + address);
//		System.out.println("높이  : " + height);
//		System.out.println("이미지번호 : " + sreachNo_img);
//		System.out.println("설명 1 : " + details);
//		System.out.println("설명 2 : " + summary);
//		System.out.println("이미지 1 : " + image1);
//		System.out.println("이미지 2 : " + image2);
//		System.out.println("이미지 3 : " + image3);
//		 
//	}
//	

	
}
