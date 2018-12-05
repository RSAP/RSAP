require 'test_helper'

class PerfilExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perfil_externo = perfil_externos(:one)
  end

  test "should get index" do
    get perfil_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_perfil_externo_url
    assert_response :success
  end

  test "should create perfil_externo" do
    assert_difference('PerfilExterno.count') do
      post perfil_externos_url, params: { perfil_externo: { link: @perfil_externo.link, nome: @perfil_externo.nome, user_id: @perfil_externo.user_id } }
    end

    assert_redirected_to perfil_externo_url(PerfilExterno.last)
  end

  test "should show perfil_externo" do
    get perfil_externo_url(@perfil_externo)
    assert_response :success
  end

  test "should get edit" do
    get edit_perfil_externo_url(@perfil_externo)
    assert_response :success
  end

  test "should update perfil_externo" do
    patch perfil_externo_url(@perfil_externo), params: { perfil_externo: { link: @perfil_externo.link, nome: @perfil_externo.nome, user_id: @perfil_externo.user_id } }
    assert_redirected_to perfil_externo_url(@perfil_externo)
  end

  test "should destroy perfil_externo" do
    assert_difference('PerfilExterno.count', -1) do
      delete perfil_externo_url(@perfil_externo)
    end

    assert_redirected_to perfil_externos_url
  end
end
