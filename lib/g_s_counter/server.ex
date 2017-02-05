defmodule GSCounter.Server do
  use GenServer
  # Server callbacks

  def handle_call(:get, _from, counter) do
    {:reply, counter, counter}
  end

  def handle_call(:increment_and_get, _from, counter) do
    {:reply, counter, counter + 1}
  end

  def handle_call(:decrement_and_get, _from, counter) do
    {:reply, counter, counter - 1}
  end

  def handle_cast(:increment, counter) do
    {:noreply, counter + 1}
  end

  def handle_cast(:decrement, counter) do
    {:noreply, counter - 1}
  end

  def handle_cast(:stop, counter) do
    {:stop, :normal, counter}
  end
end
