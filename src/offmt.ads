with Interfaces;

--  Offloaded Log Formatting

package Offmt is

   procedure Log (Str : String) is null;

   subtype U8 is Interfaces.Unsigned_8;
   subtype U16 is Interfaces.Unsigned_16;
   subtype U32 is Interfaces.Unsigned_32;

   -- Danger Zone --

   type Log_Id is new U16;

   procedure Start_Frame (Id : Log_Id);
   procedure End_Frame;

   procedure Push_U8 (V : U8);
   procedure Push_U16 (V : U16);
   procedure Push_U32 (V : U32);
end Offmt;

