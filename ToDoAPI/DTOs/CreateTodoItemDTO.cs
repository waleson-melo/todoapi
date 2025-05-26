using System.ComponentModel.DataAnnotations;

namespace ToDoAPI.DTOs;

public class CreateTodoItemDTO
{
    [Required(ErrorMessage = "O título é obrigatório.")]
    [MinLength(5, ErrorMessage = "O título deve ter no mínimo 5 caracteres.")]
    [MaxLength(100, ErrorMessage = "O título deve ter no máximo 100 caracteres.")]
    public string Title { get; set; } = string.Empty;
}
