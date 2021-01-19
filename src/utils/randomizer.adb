with Types;
with Ada.Numerics.Discrete_Random;
package body Randomizer is
    use Types;

    function Generate_Rand_U64 return U64 is
        package Rand_U64 is new Ada.Numerics.Discrete_Random(U64);
        use Rand_U64;
        Gen : Generator;
        Num : U64;
    begin
        Reset(Gen);
        Num := Random(gen);
        return Num;
    end Generate_Rand_U64;

end Randomizer;
