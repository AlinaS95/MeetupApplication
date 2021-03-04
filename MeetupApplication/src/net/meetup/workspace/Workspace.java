package net.meetup.workspace;

public class Workspace {
	protected int workspaceID;
	private String teamName;
	private String fullName;
	private String email;
	
	public Workspace() {
	}
	
	public Workspace(String teamName, String fullName, String email) {
		super();
		this.teamName = teamName;
		this.fullName = fullName;
		this.email = email;
	}
	
	public Workspace(int workspaceID, String teamName, String fullName, String email) {
		super();
		this.workspaceID = workspaceID;
		this.teamName = teamName;
		this.fullName = fullName;
		this.email = email;
	}
	
	public int getWorkspaceID() {
		return workspaceID;
	}
	public void setWorkspaceID(int workspaceID) {
		this.workspaceID = workspaceID;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
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
}
