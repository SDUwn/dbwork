package Bean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
public class Flight {
	public int flight_id;
	public String flight_state;
	public double A_price,B_price,C_price;
	public int start_id,end_id;
	public String start_time,end_time;
	public String start_city,end_city;
	public int plane_id;
	public String plane_type;
	public String company_name;
	public String start_airport;
	public String end_airport;
	public Flight() {
		flight_id=-1;
		flight_state=null;
		A_price=0;
		B_price=0;
		C_price=0;
		start_id=-1;
		end_id=-1;
		start_time=null;
		end_time=null;
		start_city=null;
		end_city=null;
		plane_id=-1;
		plane_type=null;
		company_name=null;
		start_airport=null;
		end_airport=null;
	}
	public String getTime(String from,String to) throws ParseException {
	    SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 	Date fromDate2 = simpleFormat.parse(from);  
		    Date toDate2 = simpleFormat.parse(to);  
		    long from2 = fromDate2.getTime();  
		    long to2 = toDate2.getTime();  
		    int hours = (int) ((to2 - from2) / (1000 * 60 * 60));
		    int minutes = (int) (((to2 - from2) % (1000 * 60 * 60)) / (1000 * 60));  
		    return hours+"小时"+minutes+"分钟";
	}
	public  String toString() {
		return flight_id+" "+start_city+" "+end_city+" "+start_time+" "+end_time+" "+plane_type+" "+A_price+" "+B_price+" "+C_price+" "+company_name;
	}
}
