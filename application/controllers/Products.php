<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Products extends Admin_Controller 
{
	public function __construct()
	{
		parent::__construct();

		$this->not_logged_in();

		$this->data['page_title'] = 'Món ăn';

		$this->load->model('model_products');
		$this->load->model('model_category');
		$this->load->model('model_stores');
	}

  
	public function index()
	{
        if(!in_array('viewProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }

		$this->render_template('products/index', $this->data);	
	}

    /*
    *  Nó Tìm nạp dữ liệu từ bảng món ăn
    * 
    */
	public function fetchProductData()
	{
        if(!in_array('viewProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }
        
		$result = array('data' => array());

		$data = $this->model_products->getProductData();

		foreach ($data as $key => $value) {
            $store_ids = json_decode($value['store_id']);
            
            
            $store_name = array();
            foreach ($store_ids as $k => $v) {
                $store_data = $this->model_stores->getStoresData($v);
                $store_name[] = $store_data['name'];
            }

            $store_name = implode(', ', $store_name);
            

			// button
            $buttons = '';
            if(in_array('updateProduct', $this->permission)) {
    			$buttons .= '<a href="'.base_url('products/update/'.$value['id']).'" class="btn btn-default"><i class="fa fa-pencil"></i></a>';
            }

            if(in_array('deleteProduct', $this->permission)) { 
    			$buttons .= ' <button type="button" class="btn btn-default" onclick="removeFunc('.$value['id'].')" data-toggle="modal" data-target="#removeModal"><i class="fa fa-trash"></i></button>';
            }
			

			$img = '<img src="'.base_url($value['image']).'" alt="'.$value['name'].'" class="img-circle" width="50" height="50" />';

            $availability = ($value['active'] == 1) ? '<span class="label label-success">Hoạt động</span>' : '<span class="label label-warning">Không hoạt động</span>';

			$result['data'][$key] = array(
				$img,
				$value['name'],
                $value['price'],
				$store_name,
                $availability,
				$buttons
			);
		} // /foreach

		echo json_encode($result);
	}	
    
    /*
    * xem sản phẩm dựa trên cửa hàng
    * quản trị viên có thể xem tất cả thông tin sản phẩm
    */
    public function viewproduct()
    {
        if(!in_array('viewProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }

        $company_currency = $this->company_currency();
        // Lấy tất cả các danh mục
        $category_data = $this->model_category->getCategoryData();

        $result = array();
        
        foreach ($category_data as $k => $v) {
            $result[$k]['category'] = $v;
            $result[$k]['products'] = $this->model_products->getProductDataByCat($v['id']);
        }

        // based on the category get all the products 

        $html = '<!-- Main content -->
                    <!DOCTYPE html>
                    <html>
                    <head>
                      <meta charset="utf-8">
                      <meta http-equiv="X-UA-Compatible" content="IE=edge">
                      <title>Thực đơn</title>
                      <!-- Tell the browser to be responsive to screen width -->
                      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
                      <!-- Bootstrap 3.3.7 -->
                      <link rel="stylesheet" href="'.base_url('assets/bower_components/bootstrap/dist/css/bootstrap.min.css').'">
                      <!-- Font Awesome -->
                      <link rel="stylesheet" href="'.base_url('assets/bower_components/font-awesome/css/font-awesome.min.css').'">
                      <link rel="stylesheet" href="'.base_url('assets/dist/css/AdminLTE.min.css').'">
                    </head>
                    <body>
                    
                    <div class="wrapper">
                      <section class="invoice">

                        <div class="row">
                        ';
                            foreach ($result as $k => $v) {
                                $html .= '<div class="col-md-6">
                                    <div class="product-info">
                                        <div class="category-title">
                                            <h1>'.$v['category']['name'].'</h1>
                                        </div>';

                                        if(count($v['products']) > 0) {
                                            foreach ($v['products'] as $p_key => $p_value) {
                                                $html .= '<div class="product-detail">
                                                            <div class="product-name" style="display:inline-block;">
                                                                <h5>'.$p_value['name'].'</h5>
                                                            </div>
                                                            <div class="product-price" style="display:inline-block;float:right;">
                                                                <h5>'.$company_currency . ' ' . $p_value['price'].'</h5>
                                                            </div>
                                                        </div>';
                                            }
                                        }
                                        else {
                                            $html .= 'N/A';
                                        }        
                                    $html .='</div>
                                        
                                </div>';
                            }
                        

                        $html .='
                        </div>
                      </section>
                      <!-- /.content -->
                    </div>
                </body>
            </html>';

                      echo $html;
    }

    /*
    * Nếu xác thực không hợp lệ, thì nó sẽ chuyển hướng đến trang tạo.
    * Nếu xác thực cho mỗi trường đầu vào là hợp lệ thì nó sẽ chèn dữ liệu vào cơ sở dữ liệu
    * và nó lưu thông báo hoạt động vào flashdata phiên và hiển thị trên trang quản lý sản phẩm
    */
	public function create()
	{
		if(!in_array('createProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }

		$this->form_validation->set_rules('product_name', 'Product name', 'trim|required');
		$this->form_validation->set_rules('price', 'Price', 'trim|required|numeric');
		$this->form_validation->set_rules('active', 'Active', 'trim|required');
		
	
        if ($this->form_validation->run() == TRUE) {
            // true case
        	$upload_image = $this->upload_image();

        	$data = array(
        		'name' => $this->input->post('product_name'),
        		'price' => $this->input->post('price'),
        		'image' => $upload_image,
        		'description' => $this->input->post('description'),
        		'category_id' => json_encode($this->input->post('category')),
                'store_id' => json_encode($this->input->post('store')),
        		'active' => $this->input->post('active'),
        	);

        	$create = $this->model_products->create($data);
        	if($create == true) {
        		$this->session->set_flashdata('success', 'Thêm thành công');
        		redirect('products/', 'refresh');
        	}
        	else {
        		$this->session->set_flashdata('errors', 'Lỗi !');
        		redirect('products/create', 'refresh');
        	}
        }
        else {
            // false case

        	// attributes 
        	// $attribute_data = $this->model_attributes->getActiveAttributeData();


        	// $this->data['attributes'] = $attributes_final_data;
			// $this->data['brands'] = $this->model_brands->getActiveBrands();        	
			$this->data['category'] = $this->model_category->getActiveCategory();        	
			$this->data['stores'] = $this->model_stores->getActiveStore();        	

            $this->render_template('products/create', $this->data);
        }	
	}

    /*
    * Chức năng này được gọi từ một chức năng khác để tải hình ảnh lên thư mục nội dung
    * và trả về đường dẫn hình ảnh
    */
	public function upload_image()
    {
    	// assets/images/product_image
        $config['upload_path'] = 'assets/images/product_image';
        $config['file_name'] =  uniqid();
        $config['allowed_types'] = 'gif|jpg|png';
        $config['max_size'] = '1000';

        // $config['max_width']  = '1024';s
        // $config['max_height']  = '768';

        $this->load->library('upload', $config);
        if ( ! $this->upload->do_upload('product_image'))
        {
            $error = $this->upload->display_errors();
            return $error;
        }
        else
        {
            $data = array('upload_data' => $this->upload->data());
            $type = explode('.', $_FILES['product_image']['name']);
            $type = $type[count($type) - 1];
            
            $path = $config['upload_path'].'/'.$config['file_name'].'.'.$type;
            return ($data == true) ? $path : false;            
        }
    }

    /*
    * Nếu xác thực không hợp lệ, thì nó sẽ chuyển hướng đến trang chỉnh sửa sản phẩm
    * Nếu xác thực thành công thì nó sẽ cập nhật dữ liệu vào cơ sở dữ liệu
    * và nó lưu thông báo hoạt động vào flashdata phiên và hiển thị trên trang quản lý sản phẩm
    */
	public function update($product_id)
	{      
        if(!in_array('updateProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }

        if(!$product_id) {
            redirect('dashboard', 'refresh');
        }

        $this->form_validation->set_rules('product_name', 'Product name', 'trim|required');
        $this->form_validation->set_rules('price', 'Price', 'trim|required');
        $this->form_validation->set_rules('active', 'active', 'trim|required');

        if ($this->form_validation->run() == TRUE) {
            // true case
            
            $data = array(
                'name' => $this->input->post('product_name'),
                'price' => $this->input->post('price'),
                'description' => $this->input->post('description'),
                'category_id' => json_encode($this->input->post('category')),
                'store_id' => json_encode($this->input->post('store')),
                'active' => $this->input->post('active'),
            );

            
            if($_FILES['product_image']['size'] > 0) {
                $upload_image = $this->upload_image();
                $upload_image = array('image' => $upload_image);
                
                $this->model_products->update($upload_image, $product_id);
            }

            $update = $this->model_products->update($data, $product_id);
            if($update == true) {
                $this->session->set_flashdata('success', 'Sửa thành công');
                redirect('products/', 'refresh');
            }
            else {
                $this->session->set_flashdata('errors', 'Lỗi !');
                redirect('products/update/'.$product_id, 'refresh');
            }
        }
        else {
                    
            $this->data['category'] = $this->model_category->getActiveCategory();           
            $this->data['stores'] = $this->model_stores->getActiveStore();          

            $product_data = $this->model_products->getProductData($product_id);
            $this->data['product_data'] = $product_data;
            $this->render_template('products/edit', $this->data); 
        }   
	}

    /*
    * Nó xóa dữ liệu khỏi cơ sở dữ liệu
    * và nó trả về phản hồi ở định dạng json
    */
	public function remove()
	{
        if(!in_array('deleteProduct', $this->permission)) {
            redirect('dashboard', 'refresh');
        }
        
        $product_id = $this->input->post('product_id');

        $response = array();
        if($product_id) {
            $delete = $this->model_products->remove($product_id);
            if($delete == true) {
                $response['success'] = true;
                $response['messages'] = "Xoá thành công"; 
            }
            else {
                $response['success'] = false;
                $response['messages'] = "Error in the database while removing the product information";
            }
        }
        else {
            $response['success'] = false;
            $response['messages'] = "Refersh the page again!!";
        }

        echo json_encode($response);
	}

}