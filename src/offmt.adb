with Ada.Text_IO; use Ada.Text_IO;

with System.Storage_Elements; use System.Storage_Elements;

with COBS.Stream.Encoder;

with Interfaces; use Interfaces;

package body Offmt is

   type COBS_Encoder is new COBS.Stream.Encoder.Instance with null record;

   overriding
   procedure Flush (This : in out COBS_Encoder;
                    Data : Storage_Array);

   Encoder : COBS_Encoder;

   -----------
   -- Flush --
   -----------

   overriding
   procedure Flush (This : in out COBS_Encoder;
                    Data : Storage_Array)
   is
   begin
      for Elt of Data loop
         Ada.Text_IO.Put (Character'Val (Elt));
      end loop;
   end Flush;

   -----------------
   -- Start_Frame --
   -----------------

   procedure Start_Frame (Id : Log_Id) is
   begin
      Encoder.Push (Storage_Element (Id and 16#FF#));
      Encoder.Push (Storage_Element (Shift_Right (Id, 8) and 16#FF#));
   end Start_Frame;

   ---------------
   -- End_Frame --
   ---------------

   procedure End_Frame is
   begin
      Encoder.End_Frame;
   end End_Frame;

   -------------
   -- Push_U8 --
   -------------

   procedure Push_U8 (V : U8) is
   begin
      Encoder.Push (Storage_Element (V));
   end Push_U8;

   --------------
   -- Push_U16 --
   --------------

   procedure Push_U16 (V : U16) is
   begin
      Encoder.Push (Storage_Element (V and 16#FF#));
      Encoder.Push (Storage_Element (Shift_Right (V, 8) and 16#FF#));
   end Push_U16;

   --------------
   -- Push_U32 --
   --------------

   procedure Push_U32 (V : U32) is
   begin
      Encoder.Push (Storage_Element (V and 16#FF#));
      Encoder.Push (Storage_Element (Shift_Right (V, 8) and 16#FF#));
      Encoder.Push (Storage_Element (Shift_Right (V, 16) and 16#FF#));
      Encoder.Push (Storage_Element (Shift_Right (V, 24) and 16#FF#));
   end Push_U32;

end Offmt;
