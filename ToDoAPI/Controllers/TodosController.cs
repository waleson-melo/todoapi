using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ToDoAPI.Data;
using ToDoAPI.DTOs;
using ToDoAPI.Models;

namespace ToDoAPI.Controllers;

[Route("api/[controller]")]
[ApiController]
public class TodosController : ControllerBase
{
    private readonly TodoContext _context;
    private readonly IMapper _mapper;

    public TodosController(TodoContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<TodoItemDTO>>> GetTodos()
    {
        var todoItems = await _context.TodoItems.ToListAsync();
        return Ok(_mapper.Map<IEnumerable<TodoItemDTO>>(todoItems));
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<TodoItemDTO>> GetTodoItem(int id)
    {
        var todoItem = await _context.TodoItems.FindAsync(id);

        if (todoItem == null)
            return NotFound();

        return _mapper.Map<TodoItemDTO>(todoItem);
    }

    [HttpPost]
    public async Task<ActionResult<TodoItemDTO>> CreateTodoItem(CreateTodoItemDTO dto)
    {
        var todoItem = _mapper.Map<TodoItem>(dto);
        _context.TodoItems.Add(todoItem);
        await _context.SaveChangesAsync();

        var item = _mapper.Map<TodoItemDTO>(todoItem);
        return CreatedAtAction(nameof(GetTodoItem), new { id = item.Id }, item);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateTodoItem(int id, UpdateTodoItemDTO item)
    {
        var existingItem = await _context.TodoItems.FindAsync(id);
        if (existingItem == null)
            return NotFound();

        _mapper.Map(item, existingItem);
        await _context.SaveChangesAsync();

        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteTodoItem(int id)
    {
        var todoItem = await _context.TodoItems.FindAsync(id);
        if (todoItem == null)
            return NotFound();

        _context.TodoItems.Remove(todoItem);
        await _context.SaveChangesAsync();

        return NoContent();
    }
}
