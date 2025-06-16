# Todo API

Este repositório contém uma API para gerenciamento de tarefas (TODO), desenvolvida em .NET C# para o backend e um projeto Flutter para Windows como frontend, facilitando o controle de atividades diárias.

## Funcionalidades

- Criar, listar, atualizar e remover tarefas
- Marcar tarefas como concluídas ou pendentes

## Tecnologias Utilizadas

- .NET com C#
- Flutter (Windows)
- Entity Framework
- SQLite

## Como Executar

1. Clone o repositório:
    ```bash
    git clone https://github.com/waleson-melo/todoapi
    ```
2. Abra dois terminais:
    - **Terminal 1 (Backend):**
        1. Acesse a pasta do backend:
            ```bash
            cd ToDoAPI
            ```
        2. (Opcional) Crie as migrations do Entity Framework, se necessário:
            ```bash
            dotnet ef migrations add InitialCreate
            ```
        3. (Opcional) Execute as migrações do Entity Framework:
            ```bash
            dotnet ef database update
            ```
        4. Inicie a API .NET:
            ```bash
            dotnet run
            ```

    - **Terminal 2 (Frontend):**
        1. Acesse a pasta do frontend:
            ```bash
            cd todo_flutter_app
            ```
        2. Instale as dependências do Flutter:
            ```bash
            flutter pub get
            ```
        3. Inicie o aplicativo Flutter:
            ```bash
            flutter run -d windows
            ```

## Endpoints Principais

- `GET /api/todos` - Lista todas as tarefas
- `POST /api/todos` - Cria uma nova tarefa
- `PUT /api/todos/{id}` - Atualiza uma tarefa existente
- `DELETE /api/todos/{id}` - Remove uma tarefa

## Imagens dos Projetos


## Documentos Auxiliares
[Slide minicurso](docs/NET%20+%20Flutter.pdf)

---