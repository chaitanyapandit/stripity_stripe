defmodule Stripe.CustomerBalanceTransaction do
  @moduledoc """
  Work with [Stripe `balance_transaction` objects]  (https://stripe.com/docs/api#balance_transaction_object).

  You can:
  - [Retrieve a balance transaction](https://stripe.com/docs/api#balance_transaction_retrieve)
  - [List all balance history](https://stripe.com/docs/api#balance_history)
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          available_on: Stripe.timestamp(),
          created: Stripe.timestamp(),
          currency: String.t(),
          description: String.t() | nil,
          exchange_rate: integer | nil,
          fee: integer,
          fee_details: list(Stripe.Types.fee()) | [],
          net: integer,
          source: Stripe.id() | Stripe.Source.t() | nil,
          status: String.t(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :available_on,
    :created,
    :currency,
    :description,
    :exchange_rate,
    :fee,
    :fee_details,
    :net,
    :source,
    :status,
    :type
  ]

  @plural_endpoint "customers"

  def create(id, params, opts \\ [])

  @spec create(Stripe.id(), params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
              :amount => integer,
              :currency => String.t(),
              optional(:description) => String.t(),
              optional(:metadata) => Stripe.Types.metadata()
             }
  def create(id, params, opts) do
    new_request(opts)
    |> put_endpoint("#{@plural_endpoint}/#{id}/balance_transactions")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end
end
