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

entity project_1_4 is
  Port ( 
    sw : in std_logic_vector ( 2 downto 0); -- sw(0) A sw(1) B sw(2) C_in
    --C_in : in std_logic; -- internal
    led : out std_logic_vector ( 1 downto 0) -- led(0) S  led(1) C_out
  );
end project_1_4;

architecture Behavioral of project_1_4 is

begin
    led(1) <= (sw(0) and sw(1)) or ( sw(0) and sw(2)) or ( sw(1) and sw(2));
    led(0) <= (sw(0) xor sw(1)) xor sw(2);

end Behavioral;
