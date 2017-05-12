-- BSD 2-Clause License
--
-- Copyright (c) 2017, Zack Boll
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions and the following disclaimer.
--
-- * Redistributions in binary form must reproduce the above copyright notice,
--   this list of conditions and the following disclaimer in the documentation
--   and/or other materials provided with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.

with Ada.Finalization;
with Interfaces.C.Extensions;

package Interfaces_CPP.Strings is

  --
  -- Ada friendly representation of C++ string
  --
  type CPP_String is new Ada.Finalization.Controlled with private;

  --
  -- Type to be used when interfacing with external binding code
  --
  type CPP_String_External is new Interfaces.C.Extensions.void_ptr;

  -- equivalent to empty string constructor
  overriding procedure Initialize (Object : in out CPP_String);
  -- copy constructor
  overriding procedure Adjust     (Object : in out CPP_String);
  -- deconstructor
  overriding procedure Finalize   (Object : in out CPP_String);

  -- Returns Ada String representation
  function To_Ada (Object: CPP_String) return String;
  function To_Ada (External: CPP_String_External) return String;

  -- Return C++ representation of Ada string
  function To_CPP (Input: String) return CPP_String;
  function To_CPP_External (Input: CPP_String) return CPP_String_External;

  function Image (Object: CPP_String) return String renames To_Ada;

private

  type CPP_String is new Ada.Finalization.Controlled with
    record
      cpp_str : CPP_String_External;
    end record;

end Interfaces_CPP.Strings;
