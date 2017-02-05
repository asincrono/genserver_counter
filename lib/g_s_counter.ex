defmodule GSCounter do
  @moduledoc """
  Server that implements a counter.
  """

  # Client API

  @doc """
  Starts the counter server.
  """
  @spec start_link(integer) :: {:ok, pid}
  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @doc """
  Stops de server.
  """
  @spec stop(atom) :: :ok
  def stop(node \\ Node.self()) do
    GenServer.cast({node, __MODULE__}, :stop)
  end

  @doc """
  Increments de counter.
  """
  @spec increment(atom, integer) :: :ok
  def increment(node \\ Node.self(), amount \\ 1) do
    GenServer.cast({node, __MODULE__}, {:increment, amount})
  end

  @doc """
  Increments the counter and returns the previous value.
  """
  @spec get_and_increment(atom, integer) :: :ok
  def get_and_increment(node \\ Node.self(), amount \\ 1) do
    GenServer.call({node, __MODULE__}, {:increment, amount})
  end

  @doc """
  Decrements the counter.
  """
  @spec decrement(atom, integer) :: :ok
  def decrement(node \\ Node.self(), amount \\ 1) do
    GenServer.cast({node, __MODULE__}, {:decrement, amount})
  end

  @doc """
  Decrements the counter and returns de previous value.
  """
  @spec get_and_decrement(atom, integer) :: :ok
  def get_and_decrement(node \\ Node.self(), amount \\ 1) do
    GenServer.call({node, __MODULE__}, {:decrement, amount})
  end

  @doc """
  Get counter value.
  """
  @spec get(atom) :: :ok
  def get(node \\ Node.self()) do
    GenServer.call({node, __MODULE__}, :get)
  end


  # Server Callbacks

  def handle_call({:increment, amount}, _from, counter) do
    {:reply, counter, counter + amount}
  end

  def handle_call({:decrement, amount}, _from, counter) do
    {:reply, counter, counter - amount}
  end

  def handle_call(:get, _from, counter) do
    {:reply, counter, counter}
  end

  def handle_cast({:increment, amount}, counter) do
    {:noreply, counter + amount}
  end

  def handle_cast({:decrement, amount}, counter) do
    {:noreply, counter - amount}
  end

  def handle_cast(:stop, counter) do
    {:stop, :normal, counter}
  end

  def test(node \\ Node.self()) do
    IO.puts(node)
  end
end
