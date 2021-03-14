package net.meetup.workspace;

public class Workspace {
	protected int workspaceID;
	protected String fullName;
	protected String email;
	protected String workspace;
	protected String position;
	
	public Workspace() {}
	
	public Workspace (String fullName, String email, String workspace, String position) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.workspace = workspace;
		this.position = position;
	}
	
	public Workspace(int workspaceID, String fullName, String email, String workspace, String position) {
		super();
		this.workspaceID = workspaceID;
		this.fullName = fullName;
		this.email = email;
		this.workspace = workspace;
		this.position = position;
	}
	
	public int getWorkspaceID() {
		return workspaceID;
	}
	public void setWorkspaceID(int workspaceID) {
		this.workspaceID = workspaceID;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWorkspace() {
		return workspace;
	}
	public void setWorkspace(String workspace) {
		this.workspace = workspace;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
}
