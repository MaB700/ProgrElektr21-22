----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 03:20:04 PM
-- Design Name: 
-- Module Name: project_1_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_add is
  Port ( 
    A : in std_logic; 
    B : in std_logic; 
    C_in : in std_logic;
    C_out : out std_logic;
    S : out std_logic
  );
end full_add;

architecture Behavioral of full_add is

begin
    C_out <= (A and B) or (A and C_in) or (B and C_in);
    S <= (A xor B) xor C_in;
end Behavioral;

