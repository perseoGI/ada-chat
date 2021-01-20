with Ada.Text_IO;
with Types;
with Randomizer;
with Exceptions;

package body DiffieHellman is
    use Ada.Text_IO;
    use Types;
    use Exceptions;
    --package Unsigned_64_IO is new Ada.Text_IO.modular_io(Unsigned_64);
    -- Function to compute a^m mod n
    -- TODO this could return a 0 value. Check!!!
    function Compute (Base, Exp, Modulus : U64) return U64 is
        R: U64;
        Y: U64 := 1;
        A: U64 := Base;
        M: U64 := Exp;

    begin
        while M > 0 loop
            R := M mod 2;
            -- Fast exponention
            if R = 1 then
                Y := (Y * A) mod Modulus;
            end if;
            A := (A * A) mod Modulus;
            M := M/2;
        end loop;

        return Y;

    end Compute;


    procedure Generate_Modulus_And_Base (Modulus: out U64; Base: out U64) is

    begin
        Base := Randomizer.Generate_Rand_U64;
        -- TODO modulus should be a big random prime number
        Modulus := Randomizer.Generate_Rand_U64;


    end Generate_Modulus_And_Base;

    function Generate_Secret return U64 is
        Secret_Number: U64;

    begin
        -- TODO modulus should be a big random prime number
        Secret_Number := Randomizer.Generate_Rand_U64;

        return Secret_Number;

    end Generate_Secret;


    function Create_Crypto_Payload (Secret: out U64) return Crypto_Payload is
        Payload: Crypto_Payload;
        Base: U64;
        Modulus: U64;
        Number_Tries: Positive := 1;
    begin
        while Number_Tries < 50 loop
            Generate_Modulus_And_Base(Modulus => Modulus, Base => Base);
            Payload.Base := Base;
            Payload.Modulus := Modulus;
            Secret := Generate_Secret;
            Payload.Public := Compute(Base => Base, Exp => Secret, Modulus => Modulus);

            if Payload.Public /= 0 then
                Put("Base generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Base); Put_Line("");
                Put("Modululs generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Modulus); Put_Line("");
                Put("Secret generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Secret); Put_Line("");
                Put("Public generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Payload.Public); Put_Line("");
                return Payload;
            end if;
            Number_Tries := Number_Tries + 1;
        end loop;

        raise Diffie_Hellman_Exception with "No secure Base and Modulus keys were generated after 50 tries";

    end Create_Crypto_Payload;

    procedure Test is
        P: U64 := 12207031;  -- modulus
        G: U64 := 355;   -- base
        --P: U64 := 16148168401;  -- modulus
        --G: U64 := 305175781;   -- base
        A, B, C: U64;	    -- A - Alice's Secret Key, B - Bob's Secret Key.
        Ap, Bp, Cp: U64;	-- Ap - Alice's Public Key, Bp - Bob's Public Key
        KeyA, KeyB, KeyC: U64;
        --X: Big_Positive := From_String("999999999999999999");

    begin
        Put_Line("Test: " & Integer'Image(Integer'Last ));
        -- choose secret integer for Alice's Pivate Key (only known to Alice)
        A := 30151;		-- or use rand()

        -- Calculate Alice's Public Key (Alice will send A to Bob)
        Ap := Compute(G, A, P);

        -- choose secret integer for Bob's Pivate Key (only known to Bob)
        B := 12207;		-- or use rand()
        --B := 12207031;		-- or use rand()

        -- Calculate Bob's Public Key (Bob will send Bp to Alice)
        Bp := Compute(G, B, P);

        C := 1232345;
        Cp:= Compute(G, C, P);
        -- Alice and Bob Exchanges their Public Key Ap & Bp with each other

        -- Find Secret key
        KeyA := Compute(Bp, A, P);
        KeyB := Compute(Ap, B, P);
        KeyC := Compute(Ap, C, P);

        --Put_Line("Alice's Secret Key is " & Integer'Image(KeyA) & " Bob's Secret Key is " & Integer'Image(KeyB));

        Put("Alice's Secret Key is ");
        Unsigned_64_IO.Put(KeyA);
        Put_Line("");
        Put("Bob's Secret Key is ");
        Unsigned_64_IO.Put(KeyB);
        Put_Line("");

        Put("C's Secret Key is ");
        Unsigned_64_IO.Put(KeyC);
        Put_Line("");
        --Put_Line(To_String(X));

    end Test;

end DiffieHellman;

