<?php ob_start();if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Account extends CI_Controller{
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('back_end/account_model');
        $this->load->library("form_validation");
    }
    public function Index()
    {
        //$msg = 'nguyendudhv';
        //$key = 'du.nguyen@bts.com!!!';
        //$this->load->library('encrypt');
        //$encrypted_string = $this->encrypt->encode($msg, $key);
        //echo $encrypted_string;
        //$encrypted_string = $this->encrypt->encode($msg, $key);
        //$this->load->library('session');
        if($this->session->userdata('User_BackEnd')==null)
        {
          header('location:../account/login');
        }
        else {
            $this->load->view('back_end/account/index.tpl');
        }
        
    }
    
    /*
     *Method account/login
     * HttpPost 
     */
    public  function Login()
    {
        //$this->load->helper("form");
        $this->load->model('back_end/group_model');
        $this->load->helper(array('form','url'));
        $data=array('GroupGetAll'=>$this->group_model->GetAll());
        $this->load->view("back_end/account/login_view.tpl",$data);
        //$this->load->view('back_end/group/group_login_view.tpl',$data);
    }
    public  function DoLogin()
    {
        
        $this->form_validation->set_rules("username", "Username", "trim|required|xss_clean");
        $this->form_validation->set_message('required','Bạn phải nhập tên đăng nhập');//thiet lap tuy chinh thong bao cua validation
        $this->form_validation->set_rules("password","Password","trim|required|xss_clean|callback_check_database");
        $this->form_validation->set_message('required','Bạn phải nhập mật khẩu');
        $this->form_validation->set_error_delimiters('<span style="color:red;">', '</span>');//thiet lap mau chu validation
        //$this->form_validation->set_message('password','Bạn phải nhập mật khẩu');
        if($this->form_validation->run() == FALSE)
        {
          //Field validation failed.  User redirected to login page
          //$this->load->view("back_end/account/login_view.tpl");
            header('location:../account/login');
        }
        else 
        {
            header('location:../account');
        }
    }
    
    public function check_database($password)
    {
        $username=$this->input->post("username");
        if($this->account_model->check_exist_username($username)==TRUE)
        {
            if($this->account_model->check_exist_password($password,$username)==TRUE)
            {
                header('location:../account');
            }   
        }
    }
}
ob_end_flush();
?>