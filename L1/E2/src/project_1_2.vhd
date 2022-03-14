----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 12:12:13 PM
-- Design Name: 
-- Module Name: project_1_2 - Behavioral
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

entity project_1_2 is
  Port (
  sw : in std_logic_vector (5 downto 0 );
  led : out std_logic_vector (0 downto 0)
  );
end project_1_2;

architecture Behavioral of project_1_2 is
    
begin
    led(0) <= (sw(5) and sw(2)) or (sw(4) and sw(1)) or (sw(3) and sw(0));

end Behavioral;
