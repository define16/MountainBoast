package api;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Herb {
	String addr = "http://openapi.forest.go.kr/openapi/service/mclltInfoService/getMclltSearch?";
	String sreach_type = "st=1&sw=3";	// 1. 식물일반명(유사검색) 2. 식물종학명(유사검색) 3. 식물일반명(일치검색) 4. 식물종학명(일치검색) 
	
	String serviceKey = "&serviceKey=vj4dxuSsj2rbjVI5s7bf1E0El21porvaChQRh5ggyetZiMvDs6UABEYKDA9pi7gpvI5tKW8WSysUOtBmux2M2w%3D%3D";
	int pageNo = 1; //&pageNo=54 까지
	String data[] = null;
			
	
	private String sreach_herb ;
	
	
	public String getSreach_herb() {
		return sreach_herb;
	}

	public void setSreach_herb(String sreach_herb) {
		this.sreach_herb = sreach_herb;
	}


	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}

	public static void main(String args[])	{
		infoherb ih = new infoherb();
		String addr = "http://openapi.forest.go.kr/openapi/service/mclltInfoService/getMclltSearch?";
		String sreach_type = "st=3&sw=";	// 1. 식물일반명(유사검색) 2. 식물종학명(유사검색) 3. 식물일반명(일치검색) 4. 식물종학명(일치검색) 
		String sreach_herb = null;
		String serviceKey = "&serviceKey=vj4dxuSsj2rbjVI5s7bf1E0El21porvaChQRh5ggyetZiMvDs6UABEYKDA9pi7gpvI5tKW8WSysUOtBmux2M2w%3D%3D";
		int pageNo = 1; //&pageNo=54 까지

        try { 
        	sreach_herb = URLEncoder.encode(sreach_herb, "UTF-8");
        	
        		addr = addr + sreach_type + sreach_herb + serviceKey;
//        		addr = addr + sreach_type + serviceKey + + "&numOfRows=1" + "&pageNo=" + page; //1개씩 출력
//        		addr = addr + serviceKey +"&numOfRows=534"; //전제 출력
        		
        		// parse the document
        		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
        		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
        		Document doc = dBuilder.parse(addr);
        		// root tag 
        		doc.getDocumentElement().normalize();
        		System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result
        		System.out.println(addr);
        		NodeList nList = doc.getElementsByTagName("item");
        		
        		for(int temp = 0; temp < nList.getLength(); temp++){		
        			Node nNode = nList.item(temp);
        			if(nNode.getNodeType() == Node.ELEMENT_NODE){
        								
        				Element eElement = (Element) nNode;
        				
        				System.out.println("이름 : " + getTagValue("mclltSpecsNm", eElement));
        				System.out.println("식물분류명  : " + getTagValue("plantClsscNm", eElement));
        				System.out.println("약재명 : " + getTagValue("mclltSfrmdNm", eElement));
        				System.out.println("식물과명  : " + getTagValue("plantFamlNm", eElement));
        				System.out.println("식물생태설명  : " + getTagValue("plantEclgDscrt", eElement));	        				
        				System.out.println("분포설명 : " + getTagValue("mclltDistrDscrt", eElement));
        				System.out.println("이용방법  : " + getTagValue("usMthodDscrt", eElement));
        				System.out.println("복용방법 : " + getTagValue("mclltDoseMthodDscrt", eElement));
        				System.out.println("이미지  : " + getTagValue("mclltPnrmImageFileNm", eElement));
        				System.out.println("이미지  : " + getTagValue("mclltUsRgnImageFileNm", eElement));
        				System.out.println("이미지  : " + getTagValue("mdciUsImageFileNm", eElement));
        				
        				ih.setName(getTagValue("mclltSpecsNm", eElement));
        				ih.setPlantClsscNm(getTagValue("plantClsscNm", eElement)); 
        				ih.setMclltSfrmdNm( getTagValue("mclltSfrmdNm", eElement));
        				ih.setPlantFamlNm (getTagValue("plantFamlNm", eElement));
        				ih.setPlantEclgDscrt (getTagValue("plantEclgDscrt", eElement));
        				ih.setMclltDistrDscrt (getTagValue("mclltDistrDscrt", eElement));
        				ih.setUseway (getTagValue("usMthodDscrt", eElement));
        				ih.setEatway (getTagValue("mclltDoseMthodDscrt", eElement));
        				ih.setImage1 (getTagValue("mclltPnrmImageFileNm", eElement));
        				ih.setImage2 (getTagValue("mclltUsRgnImageFileNm", eElement));
        				ih.setImage3 (getTagValue("mdciUsImageFileNm", eElement));
    		

        				
          				}	// if end
        		}	// for end
        		
				System.out.println(ih.getName());
				System.out.println(ih.getPlantClsscNm());
				System.out.println(ih.getMclltSfrmdNm());
				System.out.println(ih.getPlantFamlNm());
				System.out.println(ih.getPlantEclgDscrt());
				System.out.println(ih.getMclltDistrDscrt());
				System.out.println(ih.getUseway());
				System.out.println(ih.getEatway());
				System.out.println(ih.getImage1());
				System.out.println(ih.getImage2());
				System.out.println(ih.getImage3());
	
//						
						
        	}
        catch (Exception e) 
        {
            e.printStackTrace();
        } //try	
	}
}
