//
//  ViewController.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var moviesListTableView: UITableView!
    let descriptionSegueID = "toDescriptionSegue"
    var movies = [Movie]()
    var years = [Int]()
    var yearsString = [String]()
    var gruppedMovies: Dictionary = [String : [Movie]]()
    var titleYear = ""
    let request = AlamofireRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Запрос для получения списка фильмов, подготовка и отображение списка
        request.getMoviesList() { [weak self] moviesList in
            guard !moviesList.isEmpty else { self?.sendAlert(title: "Невозможно загрузить данные", message: "Возможно отсутствует соединение с Интернетом. Пожалуйста, повторите попытку позже."); return }
            self?.movies = moviesList
            self?.getYears()
            self?.groupMovies()
            self?.moviesListTableView.reloadData()
        }
    }

//    Названия хэдеров по годам
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        titleYear = yearsString[section]
        return yearsString[section]
    }
    
//    Количество секций по количеству годов
    func numberOfSections(in tableView: UITableView) -> Int {
        return yearsString.count
    }
    
//    Высота хэдера
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
//    Количество строк в каждой секции по количеству фильмов разных годов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gruppedMovies[titleYear]?.count ?? 0
    }
    
//    Инициализация ячеек таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let year = yearsString[indexPath.section]
        let movies = gruppedMovies[year]
        cell.movieNameLabel.text = movies![indexPath.row].name
        cell.movieNameRUSLabel.text = movies![indexPath.row].nameRus
        setRatingColor(rating: movies![indexPath.row].rating, label: cell.movieRatingLabel)
        cell.movieRatingLabel.text = "\(movies![indexPath.row].rating)"
        return cell
    }

//    Переход на второй вьюконтроллер, передача нужного фильма
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == descriptionSegueID else { return }
        guard let indexPath = moviesListTableView.indexPathForSelectedRow else { return }
        let year = yearsString[indexPath.section]
        let movies = gruppedMovies[year]
        let movieToShow = movies![indexPath.row]
        let movieDescriptionVC = segue.destination as! MovieDescriptionViewController
        movieDescriptionVC.movie = movieToShow
    }
    
//    Получение всех годов, сортировка по возрастанию, преобразования элементов в строки
    func getYears() {
        for movie in movies {
            if !years.contains(movie.year) {
                years.append(movie.year)
            }
        }
        years = years.sorted()
        for year in years {
            yearsString.append("\(year)")
        }
    }
    
//    Группировка фильмов по годам
    func groupMovies() {
        var moviesByYear = [Movie]()
        for year in yearsString {
            moviesByYear.removeAll()
            for movie in movies {
                if year == "\(movie.year)" {
                    moviesByYear.append(movie)
                    gruppedMovies.updateValue(moviesByYear, forKey: year)
                }
            }
        }
    }
}

