// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TasksContract {

    uint public taskCounter = 0;

    // Esta funcion "constructor" se ejecutará automaticamente al desplegar el contrato
    constructor() {
        createTask("Mi primer tarea de ejemplo", "tengo que hacer algo");
    }

    event TaskCreated(uint id, string title, string description, bool done, uint createdAt);
    event TaskToggleDone(uint id, bool done);

    // Se nombran los atributos de cada tarea
    struct Task {
        uint256 id;
        string title;
        string description;
        bool done;
        uint256 createdAt;
    }

    // Cada tarea tiene su id.
    mapping (uint256 => Task) public tasks;

    // Se crea una tarea, pidiendo el titulo y la descripcion
    function createTask(string memory _title, string memory _description) public {
        taskCounter++;
        tasks[taskCounter] = Task(taskCounter, _title, _description, false, block.timestamp);
        emit TaskCreated(taskCounter, _title, _description, false, block.timestamp);
    }

    // Se cambia el estado de la tarea (hecho o no hecho)
    function toggleDone(uint _id) public {
        Task memory _task = tasks[_id];
        _task.done = !_task.done;
        tasks[_id] = _task;
        emit TaskToggleDone(_id, _task.done);
    }

}