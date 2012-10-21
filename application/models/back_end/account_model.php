<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Account_model extends CI_Model{
    public function __construct()
    {
        parent::__construct();
    }
    
    public function get_All()
    {
        //$this->db->select('AccountId,UserName,Email');
        //$this->db->from('Accounts');
       $sql = "SELECT `AccountID`,`UserName`,`Email` FROM Accounts";
       $query=$this->db->query($sql);
       //header("Content-type:application/json");
       return json_encode($query->result());
    }
   
   /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_username($username)
   {
       $sql = "SELECT * FROM Accounts WHERE UserName = ?";
       $query=$this->db->query($sql,array($username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
   
    /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_password($password,$username)
   {
       $sql = "SELECT * FROM Accounts WHERE Password = ? AND UserName = ?"; 
       $query=$this->db->query($sql,array(md5($password),$username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
}
?>