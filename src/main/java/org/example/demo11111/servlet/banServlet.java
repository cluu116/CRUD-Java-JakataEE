package org.example.demo11111.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.demo11111.entity.Ban;
import org.example.demo11111.entity.MoiQuanHe;
import org.example.demo11111.respository.banRespository;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "banServlet", value = {
        "/ban/hien-thi",
        "/ban/add",
        "/ban/detail",
        "/ban/delete"
})
public class banServlet extends HttpServlet {
    banRespository respository = new banRespository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("hien-thi")) {
            this.getAll(req, resp);
        } else if (uri.contains("detail")) {
            this.detail(req, resp);
        } else if (uri.contains("delete")) {
            this.delete(req, resp);
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Ban ban = respository.getOne(Integer.valueOf(req.getParameter("id")));
        respository.delete(ban);
        getAll(req, resp);
    }


    private void detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer ID = Integer.valueOf(req.getParameter("id"));
        Ban banGetOne = respository.getOne(ID);
        req.setAttribute("banGetOne", banGetOne);
        getAll(req, resp);
    }

    private void getAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int soLuongHienThi = 5;
        String key = req.getParameter("key");
        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("key",key);
        List<Ban> bans;
        if (key == null || key.isEmpty()) {
            bans = respository.getAll();
        }else{
            bans = respository.searchBan(key);
        }
        int tinhTongTrang = (int) Math.ceil((double) bans.size() / soLuongHienThi);
        int trangMacDinh = 1;
        String trangHienTai = req.getParameter("page");
        if (trangHienTai != null && !trangHienTai.isEmpty()) {
            trangMacDinh = Integer.parseInt(trangHienTai);
        }
        int batDau = (trangMacDinh - 1) * soLuongHienThi;
        int ketThuc = Math.min(batDau + soLuongHienThi, bans.size());

        List<Ban> banList = bans.subList(batDau, ketThuc);
        req.setAttribute("bans", banList);

        req.setAttribute("tongTrang", tinhTongTrang);
        req.setAttribute("trangMacDinh", trangMacDinh);

        List<MoiQuanHe> moiQuanHes = respository.getAllMQH();
        req.setAttribute("moiQuanHes", moiQuanHes);
        req.getRequestDispatcher("/view/listBan.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("add")) {
            this.add(req, resp);
        }
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Ban bans = new Ban();
        bans.setMa(req.getParameter("ma"));
        bans.setTen(req.getParameter("ten"));
        bans.setSoThich(req.getParameter("soThich"));
        bans.setGioiTinh(Integer.valueOf(req.getParameter("gioiTinh")));
        bans.setIdMQH(Integer.valueOf(req.getParameter("idMQH")));
        respository.add(bans);
        getAll(req, resp);
    }
}
