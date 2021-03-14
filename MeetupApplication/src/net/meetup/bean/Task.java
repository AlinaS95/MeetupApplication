package net.meetup.bean;

import java.time.LocalDate;

public class Task {
	private Long taskID;
    private String title;
    private String assignee;
    private String description;
    private LocalDate targetDate;
    private boolean status;

    protected Task() {

    }

    public Task(long taskID, String title, String assignee, String description, LocalDate targetDate, boolean isDone) {
        super();
        this.taskID = taskID;
        this.title = title;
        this.assignee = assignee;
        this.description = description;
        this.targetDate = targetDate;
        this.status = isDone;
    }

    public Task(String title, String assignee, String description, LocalDate targetDate, boolean isDone) {
        super();
        this.title = title;
        this.assignee = assignee;
        this.description = description;
        this.targetDate = targetDate;
        this.status = isDone;
    }

    public Long getTaskID() {
        return taskID;
    }

    public void setTaskID(Long taskID) {
        this.taskID = taskID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAssignee() {
        return assignee;
    }

    public void setAssignee(String assignee) {
        this.assignee = assignee;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(LocalDate targetDate) {
        this.targetDate = targetDate;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (int)(taskID ^ (taskID >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Task other = (Task) obj;
        if (taskID != other.taskID)
            return false;
        return true;
    }
}
