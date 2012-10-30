<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Menu extends CI_Controller{
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('back_end/menu_model');
        $this->load->library("form_validation");
    }
    public function Index()
    {
        if($this->session->userdata('Session_User_Login')==null)
        {
          //header('location:../Menu/login');
          redirect('back_end/Menu/login');
        }
        else {
            //echo "<div style='display:none'>".$this->Menu_model->get_All()."</div>";
            $data['LoadController']='menu';
            $data['LoadAction']='index';
            $this->load->view('back_end/layouts/default/layout.tpl',$data);
        }
        
    }
    
    
    public function list_menu_ajax()
    {
        echo $this->menu_model->get_menu_root();
    }
    
    public function list_menu_child_ajax()
    {
        $parentId=$_GET['id'];
        echo $this->menu_model->get_menu_child_by_parent($parentId);
    }
    
    
    public function DeleteMenuById()
    {
       $Id=$_GET['id'];
       if($this->menu_model->check_exist_by_id($Id)==TRUE)
       {
           if($this->menu_model->delete_by_id($Id)==1)
           {
               echo "2";
           }
           else {
               echo "1";
           }
       }
       else {
           echo "0";
       }
    }
    
    public function UpdateMenuById()
    {
       $Id=$_GET['id'];
       $name=$_GET['username'];
       $url=$_GET['email'];
       if($this->menu_model->check_exist_by_id($Id)==TRUE)
       {
           //$username=$this->input->post('UserName');
           //$email=$this->input->post('Email');
           if($this->menu_model->update_by_id($Id,$name,$url)==1)
           {
               echo "1";
           }
           else {
               echo "-1";
           }
       }
       else {
           echo "0";
       }
    }
    
    public function InsertMenu()
    {
       $name=$_GET['username'];
       $url=$_GET['email'];
       if($this->menu_model->check_exist_username($name)==TRUE)
       {
           echo "0";//Ton tai username
       }
       else {
           if($this->menu_model->check_exist_username($name)==TRUE)
           {
              echo "1";//Ton tai email 
           }
           else {
               if($this->menu_model->update_by_id($Id,$name,$url)==1)
               {
                   echo "2";//Thanh cong
               }
               else {
                   echo "-1";//Khong insert duoc
               }
           }
       }
    }
}
?>