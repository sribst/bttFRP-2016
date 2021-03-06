module Time : sig
  type time

  type t = time

  val origin : time

  val next : time -> time

  val prev : time -> time

  val ( = ) : time -> time -> bool

  val before_origin : time -> bool

  val of_string : string -> time

  val to_string : time -> string

  val of_int : int -> time

  val to_int : time -> int
end

type ('t, 'a) event

type discrete

type continuous

module Discrete : sig
  val create : unit -> (discrete, 'a) event

  val map : f:('a -> 'b) -> (discrete, 'a) event -> (discrete, 'b) event
end

module Continuous : sig
  val create : unit -> (continuous, 'a) event

  val map : f:('a -> 'b) -> (continuous, 'a) event -> (continuous, 'b) event

  val map2 :
    f:('a -> 'b -> 'c) ->
    (continuous, 'a) event ->
    (continuous, 'b) event ->
    (continuous, 'c) event

  val complete : (discrete, 'a) event -> (continuous, 'a) event

  val complete_default :
    default:'a -> (discrete, 'a) event -> (continuous, 'a) event

  val previous : origin:'a -> (continuous, 'a) event -> (continuous, 'a) event

  val fix :
    fix_f:((continuous, 'a) event -> (continuous, 'a) event * 'b) ->
    (continuous, 'a) event * 'b
end

val refine : ('t, 'a) event -> Time.t -> 'a -> unit

val observe : ?produce:bool -> ('t, 'a) event -> Time.t -> 'a

val empty : ('t, 'a) event -> unit

val print_value : ('t, 'a) event -> ('a -> string) -> string -> unit

val print_time : ('t, 'a) event -> string -> unit

val get_interval_list : ('t, 'a) event -> (int * bool) list
