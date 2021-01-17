with Ada.Text_IO;
with DiffieHellman;

procedure Main is
   use Ada.Text_IO;

   -- Names renaming
   function Img (I : Integer) return String renames Integer'Image;
   --procedure Printf renames Put_Line;

begin
   DiffieHellman.Test;
end Main;
