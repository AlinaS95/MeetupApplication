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
	protected String fileName;
	protected String savePath;
	protected int wID;
	
	public User() {}
	
	public User (String firstName, String lastName, String email, String company, String position, String workspace, String password, String fileName, String savePath, int wID) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
		this.password = password;
		this.fileName = fileName;
		this.savePath = savePath;
		this.wID = wID;
	}
	
	public User(int userID, String firstName, String lastName, String email, String company, String position, String workspace, String password,String fileName, String savePath, int wID) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
		this.password = password;
		this.fileName = fileName;
		this.savePath = savePath;
		this.wID = wID;
	}
	
	public User(int userID, String firstName, String lastName, String email, String company, String position, String workspace, String fileName, int wID) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.company = company;
		this.position = position;
		this.workspace = workspace;
		this.fileName = fileName;
		this.wID = wID;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public int getWID() {
		return wID;
	}
	public void setWID(int wID) {
		this.wID = wID;
	}
}
