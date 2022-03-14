----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 04:54:49 PM
-- Design Name: 
-- Module Name: project_1_6 - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_1_6 is
    port(
        A : in std_logic_vector (7 downto 0);
        B : in std_logic_vector (7 downto 0);
        S : out std_logic_vector (8 downto 0)
        );
end project_1_6;

architecture Behavioral of project_1_6 is

begin

    S <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
    
end Behavioral;
