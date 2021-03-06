<?php 

class Category extends Admin_Controller 
{
	public function __construct()
	{
		parent::__construct();

		$this->not_logged_in();
		
		$this->data['page_title'] = 'Danh mục';
		$this->load->model('model_category');
	}

	public function index()
	{
		$this->render_template('category/index', $this->data);
	}

	public function fetchCategoryData()
	{
		$result = array('data' => array());

		$data = $this->model_category->getCategoryData();

		foreach ($data as $key => $value) {
			// button
			$buttons = '';

			if(in_array('updateCategory', $this->permission)) {
				$buttons = '<button type="button" class="btn btn-default" onclick="editFunc('.$value['id'].')" data-toggle="modal" data-target="#editModal"><i class="fa fa-pencil"></i></button>';
			}

			if(in_array('deleteCategory', $this->permission)) {
				$buttons .= ' <button type="button" class="btn btn-default" onclick="removeFunc('.$value['id'].')" data-toggle="modal" data-target="#removeModal"><i class="fa fa-trash"></i></button>';
			}

			$status = ($value['active'] == 1) ? '<span class="label label-success">Hoạt động</span>' : '<span class="label label-warning">Không hoạt động</span>';

			$result['data'][$key] = array(
				$value['name'],
				$status,
				$buttons
			);
		} // /foreach

		echo json_encode($result);
	}

	public function create()
	{
		// if(!in_array('createCategory', $this->permission)) {
		// 	redirect('dashboard', 'refresh');
		// }

		$response = array();

		$this->form_validation->set_rules('category_name', 'Category name', 'trim|required');
		$this->form_validation->set_rules('active', 'Active', 'trim|required');

		$this->form_validation->set_error_delimiters('<p class="text-danger">','</p>');

        if ($this->form_validation->run() == TRUE) {
        	$data = array(
        		'name' => $this->input->post('category_name'),
        		'active' => $this->input->post('active'),	
        	);

        	$create = $this->model_category->create($data);
        	if($create == true) {
        		$response['success'] = true;
        		$response['messages'] = 'Thêm thành công';
        	}
        	else {
        		$response['success'] = false;
        		$response['messages'] = 'Lỗi';			
        	}
        }
        else {
        	$response['success'] = false;
        	foreach ($_POST as $key => $value) {
        		$response['messages'][$key] = form_error($key);
        	}
        }

        echo json_encode($response);
	}

	public function fetchCategoryDataById($id = null)
	{
		if($id) {
			$data = $this->model_category->getCategoryData($id);
			echo json_encode($data);
		}
		
	}

	public function update($id)
	{
		// if(!in_array('updateStore', $this->permission)) {
		// 	redirect('dashboard', 'refresh');
		// }

		$response = array();

		if($id) {
			$this->form_validation->set_rules('edit_category_name', 'Category name', 'trim|required');
			$this->form_validation->set_rules('edit_active', 'Active', 'trim|required');

			$this->form_validation->set_error_delimiters('<p class="text-danger">','</p>');

	        if ($this->form_validation->run() == TRUE) {
	        	$data = array(
	        		'name' => $this->input->post('edit_category_name'),
        			'active' => $this->input->post('edit_active'),	
	        	);

	        	$update = $this->model_category->update($id, $data);
	        	if($update == true) {
	        		$response['success'] = true;
	        		$response['messages'] = 'Sửa thành công';
	        	}
	        	else {
	        		$response['success'] = false;
	        		$response['messages'] = 'Lỗi';			
	        	}
	        }
	        else {
	        	$response['success'] = false;
	        	foreach ($_POST as $key => $value) {
	        		$response['messages'][$key] = form_error($key);
	        	}
	        }
		}
		else {
			$response['success'] = false;
    		$response['messages'] = 'Error please refresh the page again!!';
		}

		echo json_encode($response);
	}

	public function remove()
	{
		// if(!in_array('deleteStore', $this->permission)) {
		// 	redirect('dashboard', 'refresh');
		// }
		
		$category_id = $this->input->post('category_id');

		$response = array();
		if($category_id) {
			$delete = $this->model_category->remove($category_id);
			if($delete == true) {
				$response['success'] = true;
				$response['messages'] = "Xoá thành công";	
			}
			else {
				$response['success'] = false;
				$response['messages'] = "Lỗi";
			}
		}
		else {
			$response['success'] = false;
			$response['messages'] = "Tải lại trang";
		}

		echo json_encode($response);
	}

}