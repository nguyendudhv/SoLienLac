<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Account_model extends CI_Model{
    public function __construct()
    {
        parent::__construct();
    }
   
   /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_username($username)
   {
       /*$this->db->select('AccountId');
       $this->db->from('Accounts');
       $this->db->where('')*/
       $sql = "SELECT * FROM Accounts WHERE UserName = ?";
       $query=$this->db->query($sql,array($username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
   
    /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_password($password,$username)
   {
       /*$this->db->select('AccountId');
       $this->db->from('Accounts');
       $this->db->where('')*/
       $sql = "SELECT * FROM Accounts WHERE Password = ? AND UserName=?";
       $query=$this->db->query($sql,array($password,$username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
}
?>