with Ada.Text_IO;
package DiffieHellman is

   type U64 is mod 2 ** 64;

   package Unsigned_64_IO is new Ada.Text_IO.modular_io(U64);

   function Compute (Base, Exp, Modulus : U64) return U64;

   procedure Test;

end DiffieHellman;
