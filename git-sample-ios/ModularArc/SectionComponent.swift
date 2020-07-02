//
//  SectionComponent.swift
//

import UIKit

@available(iOS 9.0, *)
class MASectionComponent {
    var section = 0
    var title: String?
    var components = [UIView]()
    
    init(section: Int) {
        self.section = section
    }
}

@available(iOS 9.0, *)
protocol MASectionManager: class {
    var componentViews: [MASectionComponent] {get set}
    var componentsTemp: [MASectionComponent] {get set}
    func reloadData()
    func reloadComponent(sec: Int, index: Int)
    func insertCell(sec: Int, index: Int)
    func insertComponent(view: UIView, index: Int, section: Int)
    func addComponent(view: UIView, section: Int)
    func removeComponent(index: Int, section: Int)
    func removeCell(index: Int, section: Int)
    func clearComponents()
    func clearComponents(section: Int)
    func getSection(_ sec: Int) -> MASectionComponent?
    func setSectionTitle(section: Int, title: String)
    func addComponentTop(view: UIView)
    func addComponentBottom(view: UIView)
    func setCentralizeComponents()
}

@available(iOS 9.0, *)
extension MASectionManager {
    func insertComponent(view: UIView, index: Int, section: Int = 0) {
        self.getSection(section).components.insert(view, at: index)
        self.insertCell(sec: section, index: index)
    }
    
    func addComponent(view: UIView, section: Int = 0) {
        self.getSection(section).components.append(view)
        self.reloadData()
    }
    
    func removeComponent(index: Int, section: Int = 0) {
        self.getSection(section).components.remove(at: index)
        self.removeCell(index: index, section: section)
    }
    
    func clearComponents() {
        self.componentViews.removeAll()
        self.reloadData()
    }
    
    func clearComponents(section: Int) {
        if section < self.componentViews.count {
            self.componentViews[section].components.removeAll()
            self.reloadData()
        }
    }
    
    func getSection(_ sec: Int) -> MASectionComponent? {
        let section = self.componentViews.filter {$0.section == sec}.first
        return section
    }
    
    func showLoadingComponent(icon: UIImage = #imageLiteral(resourceName: "loading"), title: String = "Carregando...", desc: String = "Por favor, aguarde.") {
        self.componentsTemp = self.componentViews
        self.clearComponents()
        self.addComponent(view: MAEmptyComponent(icon: icon, title: "Carregando...", description: "Por favor, aguarde."))
        
    }
    
    func endLoadingComponent() {
        self.clearComponents()
        self.componentViews = self.componentsTemp
        self.reloadData()
    }
    
    func showEmptyComponent(icon: UIImage = #imageLiteral(resourceName: "empty"), title: String = "Nenhum dado foi encontrado", desc: String = "Tente Novamente") {
        self.clearComponents()
        self.addComponent(view: MAEmptyComponent(icon: icon, title: title, description: desc))
    }
    
    private func getSection(_ sec: Int) -> MASectionComponent {
        let section = self.componentViews.filter {$0.section == sec}.first
        if section == nil {
            let newSection = MASectionComponent(section: sec)
            self.componentViews.append(newSection)
            return newSection
        }
        return section!
    }
    
    func setSectionTitle(section: Int, title: String) {
        self.getSection(section).title = title
        self.reloadData()
    }
}
