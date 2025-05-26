using AutoMapper;
using ToDoAPI.DTOs;
using ToDoAPI.Models;

namespace ToDoAPI.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<TodoItem, TodoItemDTO>();
        CreateMap<CreateTodoItemDTO, TodoItem>();
        CreateMap<UpdateTodoItemDTO, TodoItem>();
    }
}
