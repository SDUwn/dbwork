package Bean;

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
	public  String toString() {
		return flight_id+" "+start_city+" "+end_city+" "+start_time+" "+end_time+" "+plane_type+" "+A_price+" "+B_price+" "+C_price+" "+company_name;
	}
}
