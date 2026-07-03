import { Component } from "react";
import {
    addTask,
    getTasks,
    updateTask,
    deleteTask,
} from "./services/taskServices";

class Tasks extends Component {
    state = {
        tasks: [],
        currentTask: "",
    };

    async componentDidMount() {
        try {
            const { data } = await getTasks();

            console.log("API Response:", data);

            this.setState({
                tasks: Array.isArray(data) ? data : [],
            });
        } catch (error) {
            console.error("Failed to fetch tasks:", error);
            this.setState({
                tasks: [],
            });
        }
    }

    handleChange = ({ currentTarget: input }) => {
        this.setState({
            currentTask: input.value,
        });
    };

    handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const { data } = await addTask({
                task: this.state.currentTask,
            });

            this.setState((prevState) => ({
                tasks: [...prevState.tasks, data],
                currentTask: "",
            }));
        } catch (error) {
            console.error("Failed to add task:", error);
        }
    };

    handleUpdate = async (currentTask) => {
        const originalTasks = [...this.state.tasks];

        try {
            const tasks = [...originalTasks];

            const index = tasks.findIndex(
                (task) => task._id === currentTask
            );

            if (index === -1) return;

            tasks[index] = {
                ...tasks[index],
                completed: !tasks[index].completed,
            };

            this.setState({ tasks });

            await updateTask(currentTask, {
                completed: tasks[index].completed,
            });
        } catch (error) {
            console.error("Failed to update task:", error);
            this.setState({
                tasks: originalTasks,
            });
        }
    };

    handleDelete = async (currentTask) => {
        const originalTasks = [...this.state.tasks];

        try {
            const tasks = originalTasks.filter(
                (task) => task._id !== currentTask
            );

            this.setState({ tasks });

            await deleteTask(currentTask);
        } catch (error) {
            console.error("Failed to delete task:", error);

            this.setState({
                tasks: originalTasks,
            });
        }
    };
}

export default Tasks;