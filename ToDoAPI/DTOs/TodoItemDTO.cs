namespace ToDoAPI.DTOs;

public class TodoItemDTO
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public bool IsCompleted { get; set; }
}
