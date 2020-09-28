package Bean;

public class Passenger {
	public String pass_name;
	public String sex;
	public int age;
	public String cert_type;
	public String cert_num;
	public String telephone;
	public String mail;
	public String address;
	public int user_ID;
	public String state;
	public Passenger() {}
	public String toString(){
		return pass_name+" "+sex+" "+age+" "+cert_type+" "+cert_num;
	}
}
