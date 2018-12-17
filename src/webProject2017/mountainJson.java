/** 
등산로정보 key = 7a464eefed3a4349875aebcfea603519
명산등산로 key = d81eb01959da47409fae326a59ad1554
*/

package webProject2017;

import java.io.BufferedInputStream;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class mountainJson {
	
    public mountainJson() throws Exception{
        JSONParser jsonparser = new JSONParser();
        JSONObject jsonobject = (JSONObject)jsonparser.parse(readUrl());
        JSONObject json =  (JSONObject) jsonobject.get("features");
        JSONArray array = (JSONArray)json.get("MNTN_NM");
        for(int i = 0 ; i < array.size(); i++){
            
            JSONObject entity = (JSONObject)array.get(i);
            String  name = (String) entity.get("MNTN_NM");
            System.out.println(name);
        }

        
   }
   private static String readUrl() throws Exception {
       BufferedInputStream reader = null;
       try {
           URL url = new URL(
                   "http://www.forest.go.kr/newkfsweb/kfi/kfs/openapi/mntInfoOpenAPI.do"
                   + "?key=7a464eefed3a4349875aebcfea603519"
                   + "&searchWrd=%EC%A7%80%EB%A6%AC&pageUnit=10&pageindex=1");
           reader = new BufferedInputStream(url.openStream());
           StringBuffer buffer = new StringBuffer();
           int i;
           byte[] b = new byte[4096];
           while( (i = reader.read(b)) != -1){
             buffer.append(new String(b, 0, i));
           }
           return buffer.toString();
       } finally {
           if (reader != null)
               reader.close();
       }
   }

   
   public static void main(String[] args) {
       // TODO Auto-generated method stub
       try {
           new mountainJson();
       } catch (Exception e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
   }

}
