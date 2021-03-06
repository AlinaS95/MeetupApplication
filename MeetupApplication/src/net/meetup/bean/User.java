package net.meetup.bean;

public class User {
	protected int userID;
	protected String firstName;
	protected String lastName;
	protected String email;
	protected String company;
	protected String position;
	protected String workspace;
	protected String password;
	
	public User() {}
	
	public User (String firstName, String lastName, String email, String company, String position, String workspace, String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
		this.password = password;
	}
	
	public User(int userID, String firstName, String lastName, String email, String company, String position, String workspace, String password) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
		this.password = password;
	}
	
	public User(int userID, String firstName, String lastName, String email, String company, String position, String workspace) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
	}
	
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getWorkspace() {
		return workspace;
	}
	public void setWorkspace(String workspace) {
		this.workspace = workspace;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
